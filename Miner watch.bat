echo off 
color 0A
title Miner Watch
SETLOCAL enabledelayedexpansion
cls

:Menu
cls
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

echo Select an option:
echo 1. Run Miner Watch Without Config
echo 2. Run Miner Watch With Config
echo 3. Make a config file
echo 4. Delete the config file

set /p choice=Enter your choice (1-4): 

if "%choice%"=="1" goto miner
if "%choice%"=="2" goto miner_config
if "%choice%"=="3" goto config
if "%choice%"=="4" goto delete
goto menu

:miner_config
if exist config.txt (
    echo Loading configuration from config.txt...
    for /f "delims== tokens=1,2" %%G in (config.txt) do set %%G=%%H
	goto Miner_Watch

) else (
    goto choice
	)

:choice	
cls
choice /c YN /m "Config File Not Found. Do You Wish To Make one?"
if '%errorlevel%'=='1' goto config
if '%errorlevel%'=='2' goto menu

:config
cls
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
choice /c YN /m "Do you want the program to monitor the miner for cpu usage and restart it when the cpu usage is low?"
if '%errorlevel%'=='1' set cpu_check="YES"
if '%errorlevel%'=='2' set cpu_check="NO"
echo.
set /p cpu_usage="Please enter the cpu usage precent that the app monitors for restarting the app: (if the cpu usage is bellow this number it restarts the miner): "
echo. 
echo miner_location=%miner_location% >"config.txt"
echo miner_name=%miner_name% >>"config.txt"
echo miner_command=%miner_command% >>"config.txt"
echo timer=%timer% >>"config.txt"
echo priority=%priority% >>"config.txt"
echo cpu_check=%cpu_check% >>"config.txt"
echo cpu_usage=%cpu_usage% >>"config.txt"
goto menu

:miner
cls
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
choice /c YN /m "Do you want the program to monitor the miner for cpu usage and restart it when the cpu usage is low?"
if '%errorlevel%'=='1' set cpu_check="YES"
if '%errorlevel%'=='2' set cpu_check="NO"
echo.
set /p cpu_usage="Please enter the cpu usage precent that the app monitors for restarting the app: (if the cpu usage is bellow this number it restarts the miner): "
echo. 

:Miner_Watch
cls
Title Miner Watch is running...

:check_app
tasklist | find /i "%miner_name%">nul
if "%errorlevel%"=="0" (
    echo The Miner Is Still Running...
    
	Timeout /t %timer% /nobreak >nul
    goto cpu
) else (
start /b /%priority%%miner_location: =%\%miner_name%%miner_command%
)
goto check_app
exit
:cpu
if %cpu_check%=="YES" (
    goto cpu_checker
	) else (
	goto check_app
	)

:cpu_checker
for /f "skip=1 tokens=1" %%a in ('wmic cpu get loadpercentage') do (
    set cpu_load=%%a
	goto :cpu_checker2
	)
:cpu_checker2
if %cpu_load% LEQ %cpu_usage% (
	taskkill /f /im %miner_name: =%
	goto check_app
	) else (
	goto check_app
	)
	
:Delete
cls
set sure=0
set /p sure="If you want to delete the config file type "YES":"
if "%sure%"=="YES" (
    del "config.txt"
    echo Config file deleted!
    Timeout /t 5 /nobreak
    goto menu
    ) else (
    goto menu
    )
