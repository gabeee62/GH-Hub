import os
import json
import logging
import discord
import datetime
from Commands import plot as Plot, settings as Settings
from Utility import util
from discord.ext import commands
from dotenv import load

load(filepath='../../../.env')
token = os.getenv('DISCORD_TOKEN')
intents = discord.Intents.default()
intents.message_content = True
intents.members = True

handler = logging.FileHandler(
    filename='discord.log', encoding='utf-8', mode='w')

plots: list[dict] = json.loads(
    util.return_contents("v1.0\Database\Plots\Plots.json"))
groups: list[dict] = json.loads(
    util.return_contents("v1.0\Database\Plots\Groups.json"))

settings: dict = json.loads(
    util.return_contents("v1.0/Database/Settings/Settings.json"))
config: dict = json.loads(
    util.return_contents("v1.0/Database/Settings/Config.json"))

monitoredMessages: list = []

bot = commands.Bot(command_prefix=os.getenv('PREFIX'), intents=intents)


@bot.event
async def on_ready():
    print(f"{bot.user.name} is online and ready to plot!")


@bot.command()
async def plot(ctx, subcommand: str, *args):
    match subcommand:
        # Syntax: %plot claim <-m, -g> <-o, -n, -e> <x1> <y1> <x2> <y2> <PLOT_NAME>
        case "claim":
            newPlot: dict = {json.loads(open())}
            if args[0] == '-m' or args[0] == '-g':
                if args[1] == '-o' or args[1] == '-n' or args[1] == '-e':
                    match args[1]:
                        case '-o':
                            newPlot["dimension"] = "Overworld"
                        case '-n':
                            newPlot["dimension"] = "Nether"
                        case '-e':
                            newPlot["dimension"] = "End"
                    if args[2].isdigit() and args[3].isdigit() and args[4].isdigit() and args[5].isdigit():
                        pass
                match args[0]:
                    case '-m':
                        newPlot["owner"] = ctx.author.id
                    case '-g':
                        for group in groups:
                            if ctx.author.id == group["owner"]:
                                pass

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
            confirmMessage = await ctx.send("This will reset all settings and config options to their default values. Are you sure you want to do this?")
            monitoredMessages.append(confirmMessage)
            await confirmMessage.add_reaction("👍")
            await confirmMessage.add_reaction("👎")
        case "set":
            pass


@bot.event
async def on_raw_reaction_add(payload):
    for message in monitoredMessages:
        if message.id == payload.message_id:
            reactions = message.reactions
            for reaction in reactions:
                if payload.emoji == reaction.emoji:
                    match reaction.emoji:
                        case "👍":
                            pass
                        case "👎":
                            pass


@settings.error
async def settings_error(ctx, error):
    if isinstance(error, commands.MissingRole):
        await ctx.send("You don't have permission to change this bot's settings!")

bot.run(token, log_handler=handler, log_level=logging.DEBUG)
