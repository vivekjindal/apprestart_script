@echo off

rem		store the application information and log variables
set appname=Notepad
set exename=notepad.exe
set exepath=c:\windows\system32\
set logfile=%temp%\apprestart_script.log
set timeout=600
set /A instance=0
set waittostart=5

rem		tell user where to find logs
echo Script written by vivek.511201@gmail.com
echo Script logs are stored at %logfile%.

rem		analyze the status of running process and write to logfile
:beginsubroutine
for /F "tokens=7 delims=," %%a IN ('tasklist.exe /FI "IMAGENAME eq %exename%" /FO csv /NH /V') do set appstatus=%%a
tasklist.exe /NH /V | findstr /I %exename%
if %ERRORLEVEL%==1 set appstatus="DEAD"
echo %date%%time%    Script instance number %instance%. >> %logfile%
echo %date%%time%    Current Status of %appname% is %appstatus%. >> %logfile%

rem		goto subroutine based on appstatus
IF %appstatus%=="Running" goto healthysubroutine
IF %appstatus%=="Unknown" goto restartsubroutine
IF %appstatus%=="Not Responding" goto restartsubroutine
IF %appstatus%=="DEAD" goto startonlysubroutine

rem		take actions for healthy subroutine
:healthysubroutine
echo %date%%time%    No actions required. Script sleeping for %timeout% seconds. >> %logfile%
echo. >> %logfile%
timeout /T %timeout% /NOBREAK > nul
set /A instance=%instance%+1
goto beginsubroutine

rem		take actions for restartsubroutine
:restartsubroutine
echo %date%%time%    Killing the hung application... >> %logfile%
TASKKILL /FI "STATUS eq %appstatus%" /IM "%exename%" /F
echo %date%%time%    Waiting for %waittostart% seconds before restarting the %appname%. >> %logfile%
timeout /T %waittostart% /NOBREAK > nul
:startonlysubroutine
echo %date%%time%    Starting %appname%... >> %logfile%
START %exepath%%exename%
echo %date%%time%    No further actions required. Script sleeping for %timeout% seconds. >> %logfile%
echo. >> %logfile%
timeout /T %timeout% /NOBREAK > nul
set /A instance=%instance%+1
goto beginsubroutine