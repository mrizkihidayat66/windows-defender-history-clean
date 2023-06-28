@echo off

REM Set Execution Policy
powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force"

REM Run PowerShell Script
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "clean.ps1"

REM Pause script execution (optional)
pause
