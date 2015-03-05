@REM https://github.com/chocolatey/choco/wiki/CommandsReference


@REM https://chocolatey.org/packages/ChocolateyGUI
choco install chocolateygui -ry


@REM https://chocolatey.org/packages/ruby
@REM let's stick with chef's embedded ruby for now (install-chef.bat)
@REM  choco install ruby2 -ry

@REM https://chocolatey.org/packages/ruby2.devkit
@REM allows to update i.e. 'bigdecimal' in 'do-update_gems.bat' - will not fail though
choco install ruby2.devkit -ry


@REM https://chocolatey.org/packages/git
choco install git --params="/GitAndUnixToolsOnPath /NoAutoCrlf" -ry


@REM https://chocolatey.org/packages/Atom
choco install atom -ry

@REM https://chocolatey.org/packages/baretail
choco install baretail -ry

@REM https://chocolatey.org/packages/Console2
choco install console2 -ry

@REM https://chocolatey.org/packages/cyberduck
choco install cyberduck -ry
@REM https://chocolatey.org/packages/duck
choco install duck -ry

@REM https://chocolatey.org/packages/Firefox
choco install firefox -ry

@REM https://chocolatey.org/packages/logparser
choco install logparser -ry

@REM https://chocolatey.org/packages/procexp
choco install procexp -ry

@REM https://chocolatey.org/packages/putty.portable
choco install putty.portable -ry

@REM https://chocolatey.org/packages/SourceCodePro
choco install sourcecodepro -ry

@REM https://chocolatey.org/packages/sysinternals
choco install sysinternals -ry


EXIT 0
