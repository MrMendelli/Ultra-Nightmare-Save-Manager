@echo off

for /f "usebackq tokens=2,*" %%a in (
	`reg query "HKCU\Software\Valve\Steam" /V SteamPath`
) do (
	set steamdir=%%b
)
set steamdir=%steamdir:/=\%

for %%a in ("%userprofile%\Saved Games\id Software\DOOM") do (set savepath=%%a)

:menu
color 04
title Ultra-Nightmare Save Manager
mode con cols=60 lines=10
cls
echo     __________________________________________________
echo    /                                                  \
echo    ^|                  BACKUP/RESTORE                  ^|
echo    ^|__________________________________________________^|
echo    ^| Backup ....................................... B ^|
echo    ^| Restore ...................................... R ^|
echo    \__________________________________________________/
echo.
set /p menu=" Backup or restore DOOM saves? "
if /i "%menu%" equ "b" GOTO :backup
if /i "%menu%" equ "r" GOTO :restore
if /i "%menu%" neq "b" GOTO :invalid
if /i "%menu%" neq "r" GOTO :invalid

:backup
rmdir "%savepath%\base\generated" /s /q
robocopy "%savepath%\base\savegame.user\76561198329579577\GAME-AUTOSAVE0" "%savepath%\[Backup]\GAME-AUTOSAVE0" > nul /s
robocopy "%savepath%\base\savegame.user\76561198329579577\GAME-AUTOSAVE1" "%savepath%\[Backup]\GAME-AUTOSAVE1" > nul /s
robocopy "%savepath%\base\savegame.user\76561198329579577\GAME-AUTOSAVE2" "%savepath%\[Backup]\GAME-AUTOSAVE2" > nul /s
robocopy "%savepath%\base\savegame.user\76561198329579577\PROFILE" "%savepath%\[Backup]\PROFILE" > nul /s
robocopy "%savepath%\[Backup]\GAME-AUTOSAVE2" "%savepath%\base\generated\temp\savegame.user\76561198329579577\GAME-AUTOSAVE2" > nul /s
robocopy "%savepath%\[Backup]\PROFILE" "%savepath%\base\generated\temp\savegame.user\76561198329579577\PROFILE" > nul /s
goto :rungame

:restore
robocopy "%savepath%\[Backup]\GAME-AUTOSAVE0" "%savepath%\base\generated\temp\savegame.user\76561198329579577\GAME-AUTOSAVE0" > nul /s
robocopy "%savepath%\[Backup]\GAME-AUTOSAVE1" "%savepath%\base\generated\temp\savegame.user\76561198329579577\GAME-AUTOSAVE1" > nul /s
robocopy "%savepath%\[Backup]\GAME-AUTOSAVE2" "%savepath%\base\generated\temp\savegame.user\76561198329579577\GAME-AUTOSAVE2" > nul /s
robocopy "%savepath%\[Backup]\PROFILE" "%savepath%\base\generated\temp\savegame.user\76561198329579577\PROFILE" > nul /s
goto :rungame

:rungame
pushd "%steamdir%"
start "" Steam.exe -applaunch 379720
popd
goto :eof

:invalid
echo msgbox "Please enter 'b' or 'r'...", 0, "Error!" > "%temp%\Message.vbs"
wscript "%temp%\Message.vbs"
goto :menu