# Ultra-Nightmare Save Manager

A simple save manager for DOOM and DOOM Eternal that can be used to exploit the game's save
and checkpoint system during an Ultra-Nightmare session.

## Disclaimer:

I am _not_ responsible for any data lost as a result of using my tool or modifying it's
source. By downloading and using release builds, you are agreeing to this condition. _"Loss"_
or _"Damage"_ of personal data includes, but is not limited to:

- Lost files
- Corrupt files

I will not respond to messages asking how to recover lost or damaged data. **Use this tool at
your own risk**.

## Releases

Get the latest release [here](https://github.com/MrMendelli/Ultra-Nightmare-Save-Manager/releases/latest).

## Usage

The tool is very easy to use, simply run the game on Ultra-Nightmare, when you hit a checkpoint,
alt-tab out of the game and use `b` to create a backup of the current save data. Then enter `r`
in the event of a death, or after returning to either of the games. The games **must** be restarted
in order for the save restoration to work. This means that you cannot simply restore saves while
the game is running. To compensate for this, I have made the tool automatically reboot whichever
game you are managing at the time.

If you plan to compile this with a script compiler, make sure the compiler is set to visible console
application.

## Features

- Automatically reboots games after restoring data
- Tool can run from any location, no longer has to be with to save files
- Backup failsafe feature
- DOOM Eternal support added

## Todo

- Rewrite the entire tool in C#
