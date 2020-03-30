@echo off

color 0B
title Initial Setup
mode con cols=60 lines=10

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
cls
echo d | xcopy ".\DOOM\base\savegame.user" ".\DOOM\[Backup]" > nul /v /q /s /y
echo d | xcopy ".\DOOM\[Backup]" ".\DOOM\base\generated\temp\savegame.user" > nul /v /q /s /y
echo d | xcopy ".\DOOM\[Backup]" ".\DOOM\base\savegame.user\76561198329579577" > nul /v /q /s /y
pause
goto :eof

:restore
cls
echo d | xcopy ".\DOOM\[Backup]" ".\DOOM\base\generated\temp\savegame.user" > nul /v /q /s /y
echo d | xcopy ".\DOOM\[Backup]" ".\DOOM\base\savegame.user" > nul /v /q /s /y
goto :eof

:invalid
ECHO msgbox "Please enter 'b' or 'r'...", 0, "Error!" > "%TEMP%\Message.vbs"
wscript "%TEMP%\Message.vbs"
goto :menu