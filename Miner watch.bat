echo off 
color 0A
title Miner Watch
cls

:Intro 
echo ------------------------------------------------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------------------------------------------------
echo  _____ ______   ___  ________   _______   ________          ___       __   ________  _________  ________  ___  ___     
echo ^|\   _ \  _   \^|\  \^|\   ___  \^|\  ___ \ ^|\   __  \        ^|\  \     ^|\  \^|\   __  \^|\___   ___^|\   ____\^|\  \^|\  \    
echo \ \  \\\__\ \  \ \  \ \  \\ \  \ \   __/^|\ \  \^|\  \       \ \  \    \ \  \ \  \^|\  \^|___ \  \_\ \  \___^|\ \  \\\  \   
echo  \ \  \\^|__^| \  \ \  \ \  \\ \  \ \  \_^|/_\ \   _  _\       \ \  \  __\ \  \ \   __  \   \ \  \ \ \  \    \ \   __  \  
echo   \ \  \    \ \  \ \  \ \  \\ \  \ \  \_^|\ \ \  \\  \^|       \ \  \^|\__\_\  \ \  \ \  \   \ \  \ \ \  \____\ \  \ \  \ 
echo    \ \__\    \ \__\ \__\ \__\\ \__\ \_______\ \__\\ _\        \ \____________\ \__\ \__\   \ \__\ \ \_______\ \__\ \__\
echo     \^|__^|     \^|__^|\^|__^|\^|__^| \^|__^|\^|_______^|\^|__^|\^|__^|        \^|____________^|\^|__^|\^|__^|    \^|__^|  \^|_______^|\^|__^|\^|__^|                                                                                                                 
echo ------------------------------------------------------------------------------------------------------------------------
echo "Made By iTzMAS | If you want to donate please contact me in Discord @itzmas for donation addresses"
echo ------------------------------------------------------------------------------------------------------------------------

:miner
echo.
set /p miner_location="Please enter the location of the miner (example: C:\mining): "
echo.
set /p miner_name="Please enter the name of the exe (example: xmrig.exe): "
echo.
set /p miner_command="Please enter the command line you use to run the miner (example: xmrig.exe -o Pool_Address -u Wallet_Address): "
echo.
set /p timer="Please enter the check interval for watch miner (Time between each check in seconds): "
echo.
set /p priority="Please enter the Priority you want the process to run as(Low, Belownormal, Normal, Abovenormal, High, Realtime): "
echo.

:Miner_Watch
Title Miner Watch is running...
:check_app

tasklist | find /i "%miner_name%">nul
if "%errorlevel%"=="0" (
    echo The Miner Is Still Running...
    Timeout /t %timer% /nobreak >null
    goto check_app
) else (
start /b /%priority% %miner_location%\%miner_name% %miner_command%
)
goto check_app
pause