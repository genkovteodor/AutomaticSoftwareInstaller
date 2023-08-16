@echo off

:: Get the current Directory (where the batch file is located)
set "BatchDir=%~dp0"

:: Specify name of Powershell script
set "ScriptName=AutomaticSoftwareInstall.ps1"

::Construct the full script path
set "ScriptPath=%BatchDir%%ScriptName%"

::Check if the script exists
if not exist "%ScriptPath%" (
    echo Script not found: "%ScriptPath%"
    pause
    exit /b
)

:: Run Powershell script as administrator
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%ScriptPath%""' -Verb RunAs -Wait"