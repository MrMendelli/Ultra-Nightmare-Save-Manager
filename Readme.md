# Ultra-Nightmare Save Manager

A simple save manager for DOOM that can be used to exploit the game's save I/O and checkpoint
system during an Ultra-Nightmare session.

## Releases

Get the latest release [here](https://github.com/MrMendelli/Ultra-Nightmare-Save-Manager/releases/latest).

## Usage

The tool is very easy to use, simply run the game on Ultra-Nightmare, when you hit a checkpoint,
alt-tab out of the game and use `b` to create a backup of the current save data. Then enter `r`
in the tool upon death, or after returning to the game after exiting it previously. The game **must**
be restarted in order for the save restoration to work, I believe the game keeps some data on saves
loaded into memory while running. This means that you cannot simply restore saves while the game is
running. To compensate for this, I have made the tool automatically reboot the game.

If you plan to build this with Bat To Exe Converter, make sure `Visible application` is enabled.

## Features

- Automatically reboots the game using the Steam app ID.
- Tool can now run from any location, no longer has to be next to save files.