@REM https://github.com/chocolatey/choco/wiki/CommandsReference


@REM *** chocolatey ***

@REM make sure we have fresh choco
choco -y upgrade chocolatey
@REM for information purposes
choco feature list


@REM *** boxstarter ***

@REM install boxstarter so chef has a good time
@REM https://chocolatey.org/packages/boxstarter
choco -y install boxstarter


@REM *** ruby ***

@REM https://chocolatey.org/packages/ruby
@REM let's stick with chef's embedded ruby for now (install-chef.bat)
@REM  choco -y install ruby2

@REM https://chocolatey.org/packages/ruby2.devkit -d
@REM allows to update i.e. 'bigdecimal' in 'update-gems.bat' - will not fail though
@REM  choco -y install ruby2.devkit


@REM *** development packages ***

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

@REM https://chocolatey.org/packages/notepadplusplus.commandline
@REM choco -y install notepadplusplus.commandline
@REM https://chocolatey.org/packages/notepadplusplus.install
choco -y install notepadplusplus.install

@REM https://chocolatey.org/packages/packer
choco -y install packer

@REM https://chocolatey.org/packages/procexp
choco -y install procexp

@REM https://chocolatey.org/packages/putty.portable
@REM choco -y install putty.portable
@REM https://chocolatey.org/packages/putty.install
choco -y install putty.install

@REM https://chocolatey.org/packages/sysinternals
choco -y install sysinternals

@REM https://chocolatey.org/packages/totalcommanderpowerpack
choco -y install totalcommanderpowerpack


EXIT 0
