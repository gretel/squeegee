@REM https://github.com/chocolatey/choco/wiki/CommandsReference


@REM https://chocolatey.org/packages/ChocolateyGUI
choco -ry install chocolateygui


@REM https://chocolatey.org/packages/ruby
@REM let's stick with chef's embedded ruby for now (install-chef.bat)
@REM  choco -ry install ruby2

@REM https://chocolatey.org/packages/ruby2.devkit
@REM allows to update i.e. 'bigdecimal' in 'do-update_gems.bat' - will not fail though
choco -ry install ruby2.devkit


@REM https://chocolatey.org/packages/git
choco -ry install git --params="/GitAndUnixToolsOnPath /NoAutoCrlf"


@REM https://chocolatey.org/packages/Atom
choco -ry install atom

@REM https://chocolatey.org/packages/baretail
choco -ry install baretail

@REM https://chocolatey.org/packages/Console2
choco -ry install console2

@REM https://chocolatey.org/packages/cyberduck
choco -ry install cyberduck
@REM https://chocolatey.org/packages/duck
choco -ry install duck

@REM https://chocolatey.org/packages/Firefox
choco -ry install firefox

@REM https://chocolatey.org/packages/logparser
choco -ry install logparser

@REM https://chocolatey.org/packages/procexp
choco -ry install procexp

@REM https://chocolatey.org/packages/putty.portable
choco -ry install putty.portable

@REM https://chocolatey.org/packages/SourceCodePro
choco -ry install sourcecodepro

@REM https://chocolatey.org/packages/sysinternals
choco -ry install sysinternals


EXIT 0
