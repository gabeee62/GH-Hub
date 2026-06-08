import os
import json
import logging
import discord
from Commands import plot as Plot, settings as Settings
from Classes import plot as plotClass
from discord.ext import commands
from dotenv import load_dotenv

load_dotenv()
token = os.getenv('DISCORD_TOKEN')

handler = logging.FileHandler(
    filename='discord.log', encoding='utf-8', mode='w')
intents = discord.Intents.default()
intents.message_content = True
intents.members = True


# TODO: Make settings and config variables and use json module to interpret them

bot = commands.Bot(command_prefix=os.getenv('PREFIX'), intents=intents)
settings: dict = json.loads(open(file="../../Database/Settings/settings.json"))
config: dict = json.loads(open(file="../../Database/Settings/config.json"))


@bot.event
async def on_ready(ctx):
    await ctx.send(f"{bot.user.name} is online and ready to plot!")


@bot.command()
async def plot(ctx, subcommand: str, *args):
    match subcommand:
        # Syntax: %plot claim <-m, -g> <-o, -n, -e> <x1> <y1> <x2> <y2>
        case "claim":
            Plot.claim(
                plotClass(ctx.author, args[0], args[1], args[2], args[3], args[4], args[5]))
        # Syntax: %plot default
        case "default":
            pass
        # Syntax: %plot delete
        case "delete":
            pass
        # Syntax: %plot search name <PLOT_NAME>
        # Syntax: %plot search owner <OWNER_NAME>
        # Syntax: %plot search coords <-o, -n, -e> <x> <y> <r>
        case "search":
            match args[0]:
                case "name":
                    pass
                case "owner":
                    pass


@bot.command()
@commands.has_role("Admin")
async def settings(ctx, subcommand: str, *args):
    match subcommand:
        case "default":
            pass
        case "set":
            pass


@settings.error
async def settings_error(ctx, error):
    if isinstance(error, commands.MissingRole):
        await ctx.send("You don't have permission to change this bot's settings!")

bot.run(token, log_handler=handler, log_level=logging.DEBUG)
