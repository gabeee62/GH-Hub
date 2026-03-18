from discord.ext import commands
from dotenv import load
import discord
import logging
import utils
import games
import csv
import os

load()
token = os.getenv('DISCORD_TOKEN')

handler = logging.FileHandler(
    filename='discord.log', encoding='utf-8', mode='w')

intents = discord.Intents.default()
intents.message_content = True
intents.moderation = True
intents.members = True
intents.guilds = True

bot = commands.Bot(command_prefix='!', intents=intents)


@bot.event
async def on_connect():
    print(f"{bot.user.name} is connected.")


@bot.event
async def on_guild_join(guild):
    guild.owner.send(
        f"Hi! I'm {bot.user.name}. I was just invited to your server, {guild.name}.")


@bot.event
async def on_ready():
    print(f"{bot.user.name} is ready!")


@bot.event
async def on_member_join(member):
    await member.send(f"Welcome to the server, {member.name}!")


@bot.event
async def on_message(message):
    if message.author != bot.user:
        await bot.process_commands(message)


@bot.event
async def on_raw_reaction_add(payload):
    return


@bot.event
async def on_raw_reaction_remove(payload):
    return


@bot.command(name='assign')
@commands.has_role("Admin")
async def assign_role_to_member(ctx, arg1, arg2):

    member: discord.Member = discord.utils.get(
        ctx.guild.members, name=arg1)
    role: discord.Role = discord.utils.get(
        ctx.guild.roles, name=arg2)

    if member and role:
        await member.add_roles(role)
        await ctx.send(f"{member.mention} is now assigned to {arg2}!")
    else:
        print(member, role)
        await ctx.send("That role or user doesn't exist!")


@bot.command(name='bj')
async def blackjack(ctx):
    embed = discord.Embed(title='🃏Blackjack🃏',
                          description="🎯: Hit\n🧍‍♂️: Stand\n")
    bj_menu = await ctx.send(embed=embed)
    await bj_menu.add_reaction('🎯')
    await bj_menu.add_reaction('🧍‍♂️')


@bot.command(name='hello')
async def say_hello(ctx):
    await ctx.send(f"Hello, {ctx.author.mention}!")


@bot.command(name='helpme')
async def command_help(ctx, arg1: str):
    with open('help/' + arg1 + '.txt') as file:
        if file:
            embed = discord.Embed(title=file.read(0), description=file.read())
            message = await ctx.reply(embed=embed)


@bot.command(name='register')
async def regitser_user(ctx, email: str, password: str):
    if not ctx.guild:
        with open('accounts/accounts.csv', 'r') as file:
            reader = next(csv.reader(file, delimiter=','))
            for line in file:
                list = line.split(sep=',')
                user_id = int(list[0])
                user_email = list[1]
                if utils.match(ctx.author.id, user_id):
                    await ctx.send(f'You already have a {bot.user.name} account registered to this Discord account!')
                    return
                elif utils.match(email, user_email):
                    await ctx.send(f'A {bot.user.name} account has already been registered with this email.')
                    return
        with open('accounts/accounts.csv', 'a', newline=' ') as file:
            writer = csv.writer(file, delimiter=',')
            writer.writerow([ctx.author.id, email, password, '0', '0 '])
            await ctx.send('Your account has been registered! Thank you!')
    else:
        await ctx.author.send('Use the !register command here to register!')


@bot.command(name='remove')
@commands.has_role("Admin")
async def remove_role_from_member(ctx, arg1, arg2):
    member = discord.utils.get(ctx.guild.members, name=arg1)
    role = discord.utils.get(ctx.guild.roles, name=arg2)
    if member and role:
        await member.remove_roles(role)
        await ctx.send(f"{member.mention} has had the {arg2} role removed!")
    else:
        await ctx.send("That role or user doesn't exist!")


@bot.command(name='test')
@commands.has_role(os.getenv('TESTER_ROLE'))
async def secret(ctx):
    await ctx.author.send(f"Welcome to the club, {ctx.author.name} ;)")


@secret.error
async def test_error(ctx, error):
    if isinstance(error, commands.MissingRole):
        await ctx.send("You're not part of the cool kids club! Get outta here!")

bot.run(token, log_handler=handler, log_level=logging.DEBUG)
