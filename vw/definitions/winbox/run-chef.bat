@SET DIR=%~dp0%

@REM C:\Users\vagrant\bin\chef-solo -o "recipe[SC-win-run]"
chef-solo -o "recipe[SC-win-run]"

EXIT 0
