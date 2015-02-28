@SET DIR=%~dp0%

cmd /c chef-solo -o "recipe[SC-win-run]"

EXIT 0