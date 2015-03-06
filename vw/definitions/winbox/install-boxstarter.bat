@echo off

powershell -NoProfile -ExecutionPolicy bypass -command ". '%~dp0install-boxstarter.ps1';Get-Boxstarter %*"

timeout 5

EXIT 0
