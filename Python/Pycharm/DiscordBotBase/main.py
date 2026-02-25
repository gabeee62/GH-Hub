import discord
from discord.ext import commands
import logging
from dotenv import load
import os

load()
token = os.getenv('DISCORD_TOKEN')

handler = logging.FileHandler(filename='discord.log', encoding='utf-8', mode='w')
intents = discord.Intents.default()
intents.message_content = True
intents.members = True

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'{bot.user.name} is online!')

bot.run(token, log_handler=handler, log_level=logging.DEBUG)