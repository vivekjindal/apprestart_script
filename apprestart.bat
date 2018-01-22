@echo off

:: ##############################################################################
:: Source Repository URL:      https://github.com/vivekjindal/apprestart_script
:: Written by:  vivek.511201@gmail.com
:: ##############################################################################


:: script configuration
set appname=Notepad
set exename=notepad.exe
set exepath=c:\windows\system32
set timeout=300
set logfile=%temp%\apprestart_script.log
set /A instance=0
set waittime=5

:: clear the logfile and print log file location
type nul > %logfile%
echo Logs are being stored at %logfile%.
echo.

:: analyze the status of executable process and write to logfile
:analyze
for /F "tokens=7 delims=," %%a IN ('tasklist.exe /FI "IMAGENAME eq %exename%" /FO csv /NH /V') do set appstatus=%%a
tasklist.exe /NH /V | findstr /I %exename% > nul
if %ERRORLEVEL%==1 set appstatus="Not Running"
echo %date% %time% Script instance number is %instance%. >> %logfile% && echo %date% %time% Script instance number is %instance%.
echo %date% %time% Current Status of %appname% is %appstatus%. >> %logfile% && echo %date% %time% Current Status of %appname% is %appstatus%.

:: goto function based on appstatus
IF %appstatus%=="Running" goto running
IF %appstatus%=="Unknown" goto hung
IF %appstatus%=="Not Responding" goto hung
IF %appstatus%=="Not Running" goto notrunning

:: take actions if process is running
:running
echo %date% %time% No further action is required. Script sleeping for %timeout% seconds. >> %logfile% && echo %date% %time% No further action is required. Script sleeping for %timeout% seconds.
echo. >> %logfile% && echo.
timeout /T %timeout% /NOBREAK > nul
set /A instance=%instance%+1
goto analyze

:: take actions if process is not running or hung
:hung
echo %date% %time% Killing the hung application... >> %logfile% && echo %date% %time% Killing the hung application...
set appstatus=%appstatus:"=%
TASKKILL /FI "STATUS eq %appstatus%" /IM "%exename%" /F
echo %date% %time% Waiting for %waittime% seconds to give enough time for %appname% to be killed. >> %logfile% && echo %date% %time% Waiting for %waittime% seconds to give enough time for %appname% to be killed.
timeout /T %waittime% /NOBREAK > nul
:notrunning
echo %date% %time% Starting %appname%... >> %logfile% && echo %date% %time% Starting %appname%...
START %exepath%\%exename%
echo %date% %time% Process started and no further action is required. Script sleeping for %timeout% seconds. >> %logfile% && echo %date% %time% Process started and no further action is required. Script sleeping for %timeout% seconds.
echo. >> %logfile% && echo.
timeout /T %timeout% /NOBREAK > nul
set /A instance=%instance%+1
goto analyze
