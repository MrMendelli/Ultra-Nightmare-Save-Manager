@echo off

title Ultra-Nightmare Save Manager & color 04

for %%a in ("%userprofile%\Saved Games\id Software\DOOM") do (set DOOM_saves=%%a)

for /f "usebackq tokens=2,*" %%a in (
	`reg query "HKCU\Software\Valve\Steam" /v SteamPath`
) do (
	set steamdir=%%b
)
set steamdir=%steamdir:/=\%

:menu
mode con cols=60 lines=16
cls
echo     ____________________________________________________
echo    /                                                    \
echo    ^|                   CHOOSE A GAME                    ^|
echo    ^|____________________________________________________^|
echo    ^| DOOM 2016 ...................................... 1 ^|
echo    ^| DOOM Eternal ................................... 2 ^|
echo    ^| Exit ........................................... E ^|
echo    ^|                                                    ^|
echo    ^|                                                    ^|
echo    ^|                                                    ^|
echo    \____________________________________________________/
echo.
set /p game="Which game would you like to manage? "
if /i "%game%" equ "1" goto :doom
if /i "%game%" equ "2" goto :eternal
if /i "%game%" equ "E" goto :eof
echo Please enter one of the above options to proceed...
pause > nul
goto :menu

:doom
color 04
title Ultra-Nightmare Save Manager
mode con cols=60 lines=16
cls
echo     ____________________________________________________
echo    /                                                    \
echo    ^|                        DOOM                        ^|
echo    ^|____________________________________________________^|
echo    ^| Backup ......................................... B ^|
echo    ^| Restore ........................................ R ^|
echo    ^| Failsafe ....................................... F ^|
echo    ^| Open Folder .................................... O ^|
echo    ^| Main Menu ...................................... M ^|
echo    ^| Exit ........................................... E ^|
echo    \____________________________________________________/
echo.
set /p DOOM="Backup or restore save data? "
if /i "%doom%" equ "b" goto :doom_check
if /i "%doom%" equ "r" goto :doom_restore
if /i "%doom%" equ "f" goto :doom_failsafe
if /i "%doom%" equ "o" goto :doom_open
if /i "%doom%" equ "m" goto :menu
if /i "%doom%" equ "e" goto :eof
echo Please enter one of the above options to proceed...
pause > nul
goto :doom

:doom_check
pushd "%DOOM_saves%"
if exist [Failsafe] goto :doom_backup
if not exist [Failsafe] goto :doom_makefailsafe
popd

:doom_makefailsafe
robocopy %DOOM_saves%\base\savegame.user %DOOM_saves%\[Failsafe] /s /is > nul

:doom_backup
echo Backing files up...
robocopy %DOOM_saves%\[Backup] %DOOM_saves%\[Failsafe] /s /is > nul
robocopy %DOOM_saves%\base\savegame.user %DOOM_saves%\[Backup] /s /is > nul
echo Backup completed!
pause > nul
goto :doom

:doom_restore
echo Restoring save data...
taskkill /im DOOMx64.exe /f > nul 2>&1
taskkill /im DOOMx64vk.exe /f > nul 2>&1
robocopy %DOOM_saves%\[Backup] %DOOM_saves%\base\generated\temp\savegame.user /s /is >nul
robocopy %DOOM_saves%\[Backup] %DOOM_saves%\base\savegame.user /s /is >nul
echo Restoration complete!
start "" "%steamdir%\Steam.exe" -applaunch 379720
pause > nul
goto :doom

:doom_failsafe
echo Restoring failsafe data...
taskkill /im DOOMx64.exe /f > nul 2>&1
taskkill /im DOOMx64vk.exe /f > nul 2>&1
robocopy %DOOM_saves%\[Failsafe] %DOOM_saves%\base\generated\temp\savegame.user /s /is >nul
robocopy %DOOM_saves%\[Failsafe] %DOOM_saves%\base\savegame.user /s /is >nul
echo Restoration complete!
start "" "%steamdir%\Steam.exe" -applaunch 379720
pause > nul
goto :doom

:doom_open
explorer "%DOOM_saves%"
goto :doom

:eternal
color 04
title Ultra-Nightmare Save Manager
mode con cols=60 lines=16
cls
echo     ____________________________________________________
echo    /                                                    \
echo    ^|                    DOOM Eternal                    ^|
echo    ^|____________________________________________________^|
echo    ^| Backup ......................................... B ^|
echo    ^| Restore ........................................ R ^|
echo    ^| Failsafe ....................................... F ^|
echo    ^| Open Folder .................................... O ^|
echo    ^| Main Menu ...................................... M ^|
echo    ^| Exit ........................................... E ^|
echo    \____________________________________________________/
echo.
set /p eternal="Backup or restore save data? "
if /i "%eternal%" equ "b" goto :eternal_check
if /i "%eternal%" equ "r" goto :eternal_restore
if /i "%eternal%" equ "f" goto :eternal_failsafe
if /i "%eternal%" equ "o" goto :eternal_open
if /i "%eternal%" equ "m" goto :menu
if /i "%eternal%" equ "e" goto :eof
echo Please enter one of the above options to proceed...
pause > nul
goto :eternal

:eternal_check
pushd %steamdir%\userdata\369313849\782330\remote
if exist [Failsafe] goto :eternal_backup
if not exist [Failsafe] goto :eternal_makefailsafe
popd

:eternal_makefailsafe
pushd %steamdir%\userdata\369313849\782330\remote
echo d | xcopy GAME-AUTOSAVE0 [Failsafe]\GAME-AUTOSAVE0 /s /e /y > nul
echo d | xcopy GAME-AUTOSAVE1 [Failsafe]\GAME-AUTOSAVE1 /s /e /y > nul
echo d | xcopy GAME-AUTOSAVE2 [Failsafe]\GAME-AUTOSAVE2 /s /e /y > nul

:eternal_backup
pushd %steamdir%\userdata\369313849\782330\remote
echo Backing files up...
echo d | xcopy GAME-AUTOSAVE0 [Backup]\GAME-AUTOSAVE0 /s /e /y > nul
echo d | xcopy GAME-AUTOSAVE1 [Backup]\GAME-AUTOSAVE1 /s /e /y > nul
echo d | xcopy GAME-AUTOSAVE2 [Backup]\GAME-AUTOSAVE2 /s /e /y > nul
popd
echo Backup completed!
pause > nul
goto :eternal

:eternal_restore
pushd %steamdir%\userdata\369313849\782330\remote
echo Restoring save data...
taskkill /im DOOMEternalx64vk.exe /f > nul 2>&1
echo d | xcopy [Backup]\GAME-AUTOSAVE0 GAME-AUTOSAVE0 /s /e /y > nul
echo d | xcopy [Backup]\GAME-AUTOSAVE1 GAME-AUTOSAVE1 /s /e /y > nul
echo d | xcopy [Backup]\GAME-AUTOSAVE2 GAME-AUTOSAVE2 /s /e /y > nul
popd
echo Restoration complete!
start "" "%steamdir%\Steam.exe" -applaunch 782330
pause > nul
goto :eternal

:eternal_failsafe
pushd %steamdir%\userdata\369313849\782330\remote
echo Restoring failsafe data...
taskkill /im DOOMEternalx64vk.exe /f > nul 2>&1
echo d | xcopy [Failsafe]\GAME-AUTOSAVE0 GAME-AUTOSAVE0 /s /e /y > nul
echo d | xcopy [Failsafe]\GAME-AUTOSAVE1 GAME-AUTOSAVE1 /s /e /y > nul
echo d | xcopy [Failsafe]\GAME-AUTOSAVE2 GAME-AUTOSAVE2 /s /e /y > nul
popd
echo Restoration complete!
start "" "%steamdir%\Steam.exe" -applaunch 782330
pause > nul
goto :eternal

:eternal_open
explorer "%steamdir%\userdata\369313849\782330\remote"
goto :eternal