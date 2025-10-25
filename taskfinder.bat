@echo off
color 2
:Menu
cls
echo Choose: 1. Searc 2. Kill Task 
set /p answer="Enter 1 Or 2: "
if not defined answer goto invalid
if %answer%==1 (goto gettask)
if %answer%==2 (goto killtask)
goto invalid
:gettask
cls
set answer=
set /p search="Enter What You Wanna Search: "
if not defined search goto invalid
tasklist | findstr %search% >nul 2>&1
if %errorlevel% neq 0 (
echo Invalid Search
goto endthings
) else (
tasklist | findstr %search%
echo Command Completed Successfully
)
goto endthings
:invalid
echo Invalid Answer
goto endthings
:killtask
set answer=
cls
set /p killmode="Enter Pid Or Im: "
if not defined killmode goto invalid
if /i %killmode%==pid (goto Pid)
if /i %killmode%==im (goto im)
goto invalid
:Pid
cls
set /p PID="Enter PID: "
if not defined PID goto invalid
taskkill /pid %PID% /f >nul 2>&1
if %errorlevel% neq 0 (
echo invalid PID
goto endthings
) else (
echo Command Completed Successfully
)
goto endthings
:im
cls
set /p image="Enter IM FullName: "
if not defined image goto invalid
taskkill /im %image% /f >nul 2>&1
if %errorlevel% neq 0 (
echo Invalid IM
goto endthings
) else (
echo Command Completed Successfully
)
goto endthings
:endthings
powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\chord.wav").PlaySync();
echo ----------------------------------------
echo Press Enter To Go Back & pause >nul
goto Menu