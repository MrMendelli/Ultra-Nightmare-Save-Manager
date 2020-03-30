@echo off

color 0B
title Ultra-Nightmare Save Manager
mode con cols=60 lines=10

for /f "usebackq tokens=2,*" %%a in (
	`reg query "HKCU\Software\Valve\Steam" /V SteamPath`
) do (
	set steamdir=%%b
)
set steamdir=%steamdir:/=\%

:menu
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

if exist ".\DOOM\[Backup]" goto :restore
if not exist ".\DOOM\[Backup]" goto :backup

:backup
robocopy ".\DOOM\base\savegame.user" ".\DOOM\[Backup]" /is >nul
robocopy ".\DOOM\[Backup]" ".\DOOM\base\generated\temp\savegame.user" /is >nul
robocopy ".\DOOM\[Backup]" ".\DOOM\base\savegame.user\76561198329579577" /is >nul
pause
goto :rungame

:restore
robocopy ".\DOOM\[Backup]" ".\DOOM\base\generated\temp\savegame.user" /is >nul
robocopy ".\DOOM\[Backup]" ".\DOOM\base\savegame.user" /is >nul
goto :rungame

:rungame
pushd "%steamdir%"
start "" Steam.exe -applaunch 379720
popd
goto :eof

:invalid
ECHO msgbox "Please enter 'b' or 'r'...", 0, "Error!" > "%TEMP%\Message.vbs"
wscript "%TEMP%\Message.vbs"
goto :menu