@REM https://github.com/chocolatey/choco/wiki/CommandsReference

@REM https://chocolatey.org/packages/boxstarter
choco -y install boxstarter


@REM https://chocolatey.org/packages/ruby
@REM let's stick with chef's embedded ruby for now (install-chef.bat)
@REM  choco -y install ruby2

@REM https://chocolatey.org/packages/ruby2.devkit
@REM allows to update i.e. 'bigdecimal' in 'do-update_gems.bat' - will not fail though
choco -y install ruby2.devkit


@REM https://chocolatey.org/packages/baretail
choco -y install baretail

@REM https://chocolatey.org/packages/ConsoleZ
choco -y install consolez

@REM https://chocolatey.org/packages/cyberduck
choco -y install cyberduck
@REM https://chocolatey.org/packages/duck
choco -y install duck

@REM https://chocolatey.org/packages/Firefox
choco -y install firefox

@REM https://chocolatey.org/packages/git
choco -y install git -params '"/GitAndUnixToolsOnPath /NoAutoCrlf"'

@REM https://chocolatey.org/packages/logparser
choco -y install logparser

@REM https://chocolatey.org/packages/notepadplusplus.commandline
choco -y install notepadplusplus.commandline

@REM https://chocolatey.org/packages/procexp
choco -y install procexp

@REM https://chocolatey.org/packages/putty.portable
choco -y install putty.portable

@REM https://chocolatey.org/packages/sysinternals
choco -y install sysinternals


EXIT 0
