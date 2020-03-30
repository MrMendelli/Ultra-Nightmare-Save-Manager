@echo off

for %%a in ("%userprofile%\Saved Games\id Software\DOOM") do (set savepath=%%a)

for /f "usebackq tokens=2,*" %%a in (
	`reg query "HKCU\Software\Valve\Steam" /V SteamPath`
) do (
	set steamdir=%%b
)
set steamdir=%steamdir:/=\%

:menu
color 04
title Ultra-Nightmare Save Manager
mode con cols=60 lines=13
cls
echo     __________________________________________________
echo    /                                                  \
echo    ^|                  BACKUP/RESTORE                  ^|
echo    ^|__________________________________________________^|
echo    ^| Backup ....................................... B ^|
echo    ^| Restore ...................................... R ^|
echo    ^| Exit ......................................... E ^|
echo    \__________________________________________________/
echo.
set /p menu=" Backup or restore save data? "
if /i "%menu%" equ "b" goto :backup
if /i "%menu%" equ "r" goto :restore
if /i "%menu%" equ "e" goto :eof
echo msgbox "Please enter 'b' or 'r' to proceed.", 0, "Error!" > "%TEMP%\Message.vbs"
wscript "%TEMP%\Message.vbs" /wait
goto :menu

if exist ".\DOOM\[Backup]" goto :restore
if not exist ".\DOOM\[Backup]" goto :backup

:backup
echo Backing files up...
robocopy %savepath%\base\savegame.user %savepath%\[Backup] /s /is > nul
echo Backup complete!
pause > nul
goto :menu


:restore
echo Restoring save data...
taskkill /im DOOMx64.exe /f >nul 2>&1
taskkill /im DOOMx64vk.exe /f >nul 2>&1
robocopy %savepath%\[Backup] %savepath%\base\generated\temp\savegame.user /s /is >nul
robocopy %savepath%\[Backup] %savepath%\base\savegame.user /s /is >nul
echo Restoration complete!
start "" "%steamdir%\Steam.exe" -applaunch 379720
pause > nul
goto :menu