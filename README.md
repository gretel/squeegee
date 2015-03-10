## Squeegee [tech.]

Provisioning nice and shiny **Windows** operating system environments has not always been a easy task. Now, with **Squeegee** in your toolbox you can feel the spirit of **Microsoft** again.

![Squeegee Logo](https://raw.githubusercontent.com/gretel/squeegee/master/doc/squeegee.jpeg "tool of clear vision")

**Squeegee** by itself does not do much. It glues together the properties of some supergood opensource projects. So what do we got here?

- _Template-based_ creation and export ([Vagrant](https://www.vagrantup.com/)) of windows boxen ([Veewee](https://github.com/jedi4ever/veewee))
- Ruby-esque configuration of [VirtualBox](http://www.virtualbox.org/) VM provider
- Streamlined and _unattended_ installation utilizing *Windows Assessment and Deployment Kit* ([ADK](http://www.microsoft.com/en-us/download/details.aspx?id=30652))
- Full support of *Windows Remote Management* ([WinRM](https://msdn.microsoft.com/en-us/library/aa384426(v=vs.85).aspx)) interface
- Integrated installation of [Opscode Chef](https://www.chef.io/) 12 ([for Windows](https://www.chef.io/solutions/windows/))
- Repeatable, _reboot resilient_ software package management using [Chocolatey](https://chocolatey.org/) packages ([Boxstarter](http://boxstarter.org/))
- [PowerShell](http://social.technet.microsoft.com/wiki/contents/articles/4725.powershell-v3-guide.aspx) 3, [CMD.EXE](http://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/cmd.mspx) and [Cygwin](http://cygwin.com/) (installs using `Chocolatey`) supported
- No hacks or dirty tricks, industry-standard _open-source_ software (except [Windows](https://www.youtube.com/watch?v=cif674rUyNE) :)

## Quick introduction

My machine is not so fast therefore provisioning takes a awful long time. Please have a look though:

![Building a boxen](https://raw.githubusercontent.com/gretel/squeegee/master/doc/build.gif "$ bundle exec veewee vbox build winbox")

## Supported Source Platform

- Apple OS X ([Yosemite](https://en.wikipedia.org/wiki/OS_X_Yosemite))

> Should work on 10.9 while this version is not supported.

## Supported Target Platform

- Microsoft Windows [Server 2012 R2](http://www.microsoft.com/en-us/server-cloud/products/windows-server-2012-r2/default.aspx)

> By default, a 180-days trial version is automagically retrieved. A serial number can be set - please see below.

## Installation

### Requirements

- Ruby 2 (author is currently using `2.2.0`)
- Git
- [Homebrew Cask](http://caskroom.io/)

> Experienced users may of course install everything on their own. Following these instructions will give you a auto-updateable toolchain.

#### Homebrew

If you have not installed **VirtualBox** previously now is a good time to do so:

```shell
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#### Homebrew Cask

To install binary blobs in a managed we just add a Cask room:

```shell
$ brew install caskroom/cask/brew-cask
```

#### VirtualBox

Now, **VirtualBox** can be installed easily:

```shell
$ brew cask update
$ brew cask install virtualbox
```

To update **VirtualBox** and **Vagrant** in a cronjob running weekly or so:

```
$ brew cask update
$ brew cask install virtualbox --force
$ brew cask install vagrant --force
```

If you intend to manually interfere with **VirtualBox** you can lookup it's info:

```text
$ brew cask info virtualbox
virtualbox: x.y.zz-bbbbb
VirtualBox
http://www.virtualbox.org
/opt/homebrew-cask/Caskroom/virtualbox/x.y.zz-bbbbb (4 files, mmmM)
https://github.com/caskroom/homebrew-cask/blob/master/Casks/virtualbox.rb
==> Contents
  /Applications/VirtualBox.app/Contents/MacOS/VBoxManage (binary)
  /Applications/VirtualBox.app/Contents/MacOS/VBoxHeadless (binary)
  VirtualBox.pkg (pkg)
```

#### Vagrant (optional)

If you intend to export the **VirtualBox** container for transportation purposes **Vagrant** has to be installed, too:

```shell
$ brew cask install vagrant
```

#### Clone and bundle

To resolve Rubygem dependencies [Bundler](http://bundler.io/) is used, so let's give it a call. OS X system's default Rubygems requires superuser priviliges to install gems, doh:

```shell
$ sudo gem install bundler
```

If you use a Ruby version from **Homebrew** (`brew install ruby; brew link --force ruby`) or prefer to use `ry`, `rbenv` or `direnv` you might not need no `sudo`:

```shell
$ gem install bundler
```

Now, have a clone of **Squeegee** from GitHub and actually install the dependencies:

```shell
$ git clone --depth 1 https://github.com/gretel/squeegee.git
$ cd squeegee
$ bundle
```

The result should look as satisfying as:

```text
Bundle complete! 8 Gemfile dependencies, 104 gems now installed.
```

Mind the wrapping calls to `bundle` to ensure **Veewee** will be able to resolve it's dependencies. Check if the template supplied is defined as expected:

```text
$ bundle exec veewee vbox list
The following definitions are available in /Users/hensel/Sync/prjcts/squeegee:
- winbox
```

Great! We are ready to go on and provision a boxen.

## Provisioning

### Session Configuration

Veewee is configured in Ruby at `vw/definitions/winbox/definition.rb`. Please see the [documentation](http://www.veewee.org/docs/vbox/) for in-depth information.

```ruby
# https://github.com/jedi4ever/veewee/blob/master/doc/customize.md
Veewee::Session.declare({
  :cpu_count => '2',
  :memory_size=> '3072',
  :video_memory_size=> '64',
  :os_type_id => 'Windows8_64',
  :iso_download_instructions => 'Download and install full featured software for 180-day trial at http://technet.microsoft.com/en-US/evalcenter/hh670538.aspx',
  :iso_file => '9200.16384.WIN8_RTM.120725-1247_X64FRE_SERVER_EVAL_EN-US-HRM_SSS_X64FREE_EN-US_DV5.ISO',
  :iso_md5 => '8503997171f731d9bd1cb0b0edc31f3d',
  :iso_src => 'http://care.dlservice.microsoft.com//dl/download/6/D/A/6DAB58BA-F939-451D-9101-7DE07DC09C03/9200.16384.WIN8_RTM.120725-1247_X64FRE_SERVER_EVAL_EN-US-HRM_SSS_X64FREE_EN-US_DV5.ISO',
  :iso_download_timeout => '1800',
  :disk_size => '20280', :disk_format => 'VDI', :hostiocache => 'on',
  :floppy_files => [
    'Autounattend.xml',
    'oracle-cert.cer'
  ],
  :boot_wait => '3',
  :boot_cmd_sequence => [''],
  :kickstart_port => '7122',
  :winrm_user => 'vagrant',
  :winrm_password => 'vagrant',
  :postinstall_timeout => '10000',
  :postinstall_files => [
     'install-chocolatey.bat', 'run-chocolatey.bat',
     'install-chef.bat', 'do-update_gems.bat', 'run-chef.bat',
     'install-vbox.bat',
     'do-reboot.bat'
  ],
  # No sudo on windows
  :sudo_cmd => '%f',
  :shutdown_cmd => 'shutdown /s /t 10 /f /d p:4:1 /c "Vagrant Shutdown"',
  :virtualbox => {
    :vm_options => [
      'audio' => 'coreaudio',
      'audiocontroller' => 'hda',
      'ioapic' => 'on',
      'rtcuseutc' => 'on',
      'usb' => 'on',
      'mouse' => 'usbtablet',
      'accelerate2dvideo' => 'on',
      'accelerate3d' => 'off',
      'clipboard' => 'bidirectional'
      # A Full list of settings can be found here: http://virtualbox.org/manual/ch08.html#idp51057568
      # Or generated based on the current settings of a virtualbox guest:
      # VBoxManage showvminfo --machinereadable 'winbox'
    ]
  }
})
```
### Post-Installation

The `.bat` files declared in `postinstall_files` will be executed in the order specified. These are ***optional*** - **Windows** will be setup for **WinRM** management anyways.

This is what happens using the definitions above:

1. Install **Chocolatey**
2. Install packages using **Chocolatey**
3. Install **Chef**
4. Update **Rubygems** and the gems brought by **Chef**
5. Run **Chef** client (to check if everything is setup fine)
6. Install **VirtualBox** Guest Addons
7. Reboot gracefully

> **Boxstarter** is installed prior to **Chef** so you may use all the choco-tasty [packages available](https://chocolatey.org/packages) to start your **Windows** cookbook development work.

Various combinations are possible, like installing **Chef** via **Chocolatey** or having **Boxstarter** installed first and skip to **Chef**.. use your imagination.

### Unattended Installation

The script generated by the mighty [ADK](https://technet.microsoft.com/en-us/library/hh825039.aspx) is at `vw/definitions/winbox/Autounattend.xml`.

Please see and edit

* `ProductKey`
* `SkipAutoActivation`

to automagically activate your copies of Windows. Additional configuration keys of interest are:

* `AdministratorPassword`
* `ComputerName`
* `FullName`
* `Organization`
* `TimeZone`

> Please be careful editing the **WinRM** related settings as you may effectively lock yourself out of the boxen.

### Build and run boxen

Now the fun part starts! To begin we need to build a boxen:

```shell
$ bundle exec veewee vbox build winbox
```

Please wait a bit until the **VirtualBox** window comes up.

If you would like to overwrite a previous build do:

```shell
$ bundle exec veewee vbox build winbox --force
```

## Usage Examples

Bring up the boxen we have built, again:

```shell
$ bundle exec veewee vbox up
```

Take a screenshot and save it to current (local) directory:

```shell
$ bundle exec veewee vbox screenshot winbox screen.png
Saving screenshot of vm winbox in screen.png
```

Veewee includes a PowerShell-based approach to interactive management - you should check it out:

```text
$ bundle exec veewee vbox winrm winbox
This is a simple interactive shell
To exit interactive mode, use 'quit!'
veewee> VER
Executing winrm command: VER

Microsoft Windows [Version 6.2.9200]
veewee> quit!
```

To bring up the boxen and shut it down five minuter later:

```text
$ bundle exec veewee vbox up winbox; sleep 300s; bundle exec veewee vbox halt winbox
Finding unused TCP port in range: 5985 - 6025
Selected TCP port 5985
Waiting for winrm login on 127.0.0.1 with user vagrant to windows on port => 5985 to work, timeout=10000 sec
.
Executing winrm command: shutdown /s /t 10 /f /d p:4:1 /c "Vagrant Shutdown"
```

## Management

While **WinRM** offers a SSH-like approach to remote management using **Chef** nicely meets our contemporary demands. Invoke `chef-client` like this:

```text
$ bundle exec veewee vbox winrm winbox chef-solo
Executing winrm command: chef-solo
{:config_missing=>true}
[2015-02-28T22:14:00-08:00] WARN: *****************************************
[2015-02-28T22:14:00-08:00] WARN: Did not find config file: C:\chef\solo.rb, using command line options.
[2015-02-28T22:14:00-08:00] WARN: *****************************************
[2015-02-28T22:14:05-08:00] INFO: *** Chef 12.0.3 ***
[2015-02-28T22:14:05-08:00] INFO: Chef-client pid: 2240
[2015-02-28T22:14:36-08:00] INFO: Run List is []
[2015-02-28T22:14:36-08:00] INFO: Run List expands to []
[2015-02-28T22:14:36-08:00] INFO: Starting Chef Run for winbox
[2015-02-28T22:14:36-08:00] INFO: Running start handlers
[2015-02-28T22:14:36-08:00] INFO: Start handlers complete.
[2015-02-28T22:14:36-08:00] FATAL: None of the cookbook paths set in Chef::Config[:cookbook_path], ["C:\\chef\\cookbooks", "C:\\chef\\site-cookbooks"], contain any cookbooks
[2015-02-28T22:14:36-08:00] ERROR: Running exception handlers
[2015-02-28T22:14:36-08:00] ERROR: Exception handlers complete
[2015-02-28T22:14:36-08:00] FATAL: Stacktrace dumped to C:/chef/cache/chef-stacktrace.out
[2015-02-28T22:14:36-08:00] FATAL: Chef::Exceptions::CookbookNotFound: None of the cookbook paths set in Chef::Config[:cookbook_path], ["C:\\chef\\cookbooks", "C:\\chef\\site-cookbooks"], contain any cookbooks
```

> Whoa! Looks like somebody forget to specify the `run-list`.

Shells commands can be executed easily, like to get their result. Let's go for `SYSTEMINFO`:

```text
$ bundle exec veewee vbox winrm winbox SYSTEMINFO
Executing winrm command: SYSTEMINFO

Host Name:                 WINBOX
OS Name:                   Microsoft Windows Server 2012 Standard Evaluation
OS Version:                6.2.9200 N/A Build 9200
OS Manufacturer:           Microsoft Corporation
OS Configuration:          Standalone Server
OS Build Type:             Multiprocessor Free
Registered Owner:
Registered Organization:   Some Corp
Product ID:                00183-90000-00001-AA422
Original Install Date:     2/28/2015, 1:39:43 PM
System Boot Time:          2/28/2015, 10:07:20 PM
System Manufacturer:       innotek GmbH
System Model:              VirtualBox
System Type:               x64-based PC
Processor(s):              1 Processor(s) Installed.
                           [01]: Intel64 Family 6 Model 42 Stepping 7 GenuineIntel ~2008 Mhz
BIOS Version:              innotek GmbH VirtualBox, 12/1/2006
Windows Directory:         C:\Windows
System Directory:          C:\Windows\system32
Boot Device:               \Device\HarddiskVolume1
System Locale:             en-us;English (United States)
Input Locale:              en-us;English (United States)
Time Zone:                 (UTC-08:00) Pacific Time (US & Canada)
Total Physical Memory:     2,048 MB
Available Physical Memory: 1,422 MB
Virtual Memory: Max Size:  2,997 MB
Virtual Memory: Available: 2,316 MB
Virtual Memory: In Use:    681 MB
Page File Location(s):     C:\pagefile.sys
Domain:                    WORKGROUP
Logon Server:              N/A
Hotfix(s):                 3 Hotfix(s) Installed.
                           [01]: KB2887535
                           [02]: KB2887536
                           [03]: KB2887537
Network Card(s):           1 NIC(s) Installed.
                           [01]: Intel(R) PRO/1000 MT Desktop Adapter
                                 Connection Name: Ethernet
                                 DHCP Enabled:    Yes
                                 DHCP Server:     10.0.2.2
                                 IP address(es)
                                 [01]: 10.0.2.15
                                 [02]: fe80::6d8d:97e0:dae3:e495
Hyper-V Requirements:      VM Monitor Mode Extensions: No
                           Virtualization Enabled In Firmware: No
                           Second Level Address Translation: No
                           Data Execution Prevention Available: Yes
```

Much more in-depth information can be provided by calling `ohai`:

```shell
$ bundle exec veewee vbox winrm winbox ohai
```
```json
{
  "cpu": {
    "0": {
      "vendor_id": "GenuineIntel",
      "family": "2",
      "model": "10759",
      "stepping": null,
      "physical_id": "CPU0",
      "cores": 2,
      "model_name": "Intel64 Family 6 Model 42 Stepping 7",
      "mhz": "2008",
      "cache_size": " KB"
    },
    "total": 2,
    "real": 1
  },
  "filesystem": {
    "A:": {
      "kb_size": 0,
      "kb_available": 0,
      "kb_used": 0,
      "percent_used": 0,
      "mount": "A:",
      "volume_name": null
    },
    "C:": {
      "kb_size": 10485755,
      "kb_available": 29253,
      "kb_used": 10456502,
      "percent_used": 99,
      "mount": "C:",
      "fs_type": "ntfs",
      "volume_name": "Windows 2012"
    },
```

Output is truncated - *beware*! It's a big bunch of data. Consider using some fast `JSON` support like [oj](https://github.com/ohler55/oj).

## Export boxen to Vagrant format

**Vagrant** has to be installed first (see above). It's a pleasure to export using **Veewee**:

```text
$ bundle exec veewee vbox export winbox
Creating a temporary directory for export
Adding additional files
Creating Vagrantfile
Exporting the box
Executing VBoxManage export "winbox" --output "/var/folders/g3/831951dd0xnf79ld_yvf8fc00000gn/T/d20150305-2744-u8gl28/box.ovf"
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Successfully exported 1 machine(s).
Packaging the box
Cleaning up temporary directory

To import it into vagrant type:
vagrant box add 'winbox' '/Users/hensel/Sync/prjcts/squeegee/winbox.box'
[...]
```
> May take a long time. Very fast boxen recommended!

Please note: `vagrant ssh` will not work - just use **WinRM** instead. Alternatively, you may export a boxen with a SSH-daemon set up.

Please see the included `Vagrantfile` for configuration options:

```ruby
# https://docs.vagrantup.com/v2/vagrantfile/index.html
# https://github.com/WinRb/vagrant-windows
Vagrant.configure(2) do |config|
  config.vm.box = "winbox.box"
  config.vm.guest = :windows
  # switch from 'home' to 'work' network mode (required for Windows 7 and up)
  config.windows.set_work_network = true
  # RDP
  config.vm.network :forwarded_port, guest: 3389, host: 3389
  # WinRM
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
end
```

## Bootstrap cookbook

In addition to **Squeegee** a according Chef cookbook allows to further configure and setup the Windows system in a industry-standard manner. By default a cookbook named `squeegee-run` is used by **Chef** just when the **Windows** installation finishes (see `vw/defintions/winbox/run-chef.bat`).

Please see it's GitHub page at [squeegee-run](https://github.com/gretel/squeegee-run).

## License and Authors

Author:: [Tom Hensel](https://www.linkedin.com/pub/dir/tom/hensel) (github@jitter.eu)

> Live long and prosper!
