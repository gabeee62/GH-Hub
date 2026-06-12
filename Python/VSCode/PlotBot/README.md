# README

## INSTALLATION GUIDE

1. Download this repository as a ZIP file and extract its contents, then open the extracted folder as a workspace inside VSCode.
2. Go to the [Discord Developer Portal](https://discord.com/developers/home) and create a new blank application. You must have developer mode enabled on your Discord account to do this.
3. In the application's OAuth2 page under the OAuth2 URL Generator, enable the "bot" scope.
4. Under the UI that appears after completing Step 3, enable the "Send Messages" and "Embed Links" permissions.
5. In the application's Bot page under Bot Permissions, enable the same permissions.
6. Reset the bot's token and copy it. Go to the .env file and replace the "TOKEN_GOES_HERE" variable with the new token, then save the file.
7. Return to the application's OAuth2 page and copy + paste the install link into your browser. You should now see a popup in your Discord client to allow the bot to join a server you own.
8. Run the "PlotBot.py" file in the folder that matches the bot version you wish to run (currently only v1.0). The bot should now be fully operational on your server.

# USER GUIDE

## SETUP

## CLAIMING PLOTS

- **Syntax**: %plot claim <type: -m, -g> <dimension: -o, -n, -e> "<x1> <z1> <x2> <z2>" <PLOT_NAME>

- **Claim Type**:
    - -m: Member/Individual Plot
    - -g: Group Plot
        - In order to claim a plot for a group, you must be the group's owner.
- **Dimension**: 
    - -o: Overworld
    - -n: Nether
    - -e: The End
- **Coordinates**: 
    - x1, z1: Find the corner of your plot where your x and z coordinates are at their lowest (most negative).
    - x2, z2: Find the corner of your plot where your x and z coordinates are at their highest (most positive).
- **Plot Name**: Avoid using symbols or spaces. Numbers are permitted.



## SEARCHING FOR PLOTS


# LICENSING

- This bot is is freely available for personal and non-commercial use.
- You may edit, add to, or remove parts of the bot as you see fit.
- You may NOT redistribute this code or versions of it--modified or not--as your own.
- You may NOT sell this code or versions of it, modified or not.