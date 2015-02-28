@SET DIR=%~dp0%

cmd /c chef-solo -o "recipe[squeegee-run]"

EXIT 0