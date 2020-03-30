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
echo Backing files up...
taskkill /im DOOMx64.exe /f >nul 2>&1
taskkill /im DOOMx64vk.exe /f >nul 2>&1
robocopy %savepath%\base\savegame.user %savepath%\[Backup] /s /is > nul
robocopy %savepath%\[Backup] ".\DOOM\base\generated\temp\savegame.user" /is >nul
robocopy %savepath%\[Backup] ".\DOOM\base\savegame.user\76561198329579577" /is >nul
goto :rungame

:restore
echo Restoring save data...
taskkill /im DOOMx64.exe /f >nul 2>&1
taskkill /im DOOMx64vk.exe /f >nul 2>&1
robocopy %savepath%\[Backup] ".\DOOM\base\generated\temp\savegame.user" /is >nul
robocopy %savepath%\[Backup] ".\DOOM\base\savegame.user" /is >nul
goto :rungame

:rungame
pushd "%STEAMDIR%"
start "" Steam.exe -applaunch 379720
popd
goto :eof

:invalid
echo msgbox "Please enter 'b' or 'r'...", 0, "Error!" > "%temp%\Message.vbs"
wscript "%temp%\Message.vbs"
goto :menu