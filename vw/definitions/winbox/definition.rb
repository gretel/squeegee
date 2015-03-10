# https://github.com/jedi4ever/veewee/blob/master/doc/customize.md
Veewee::Session.declare({
  :cpu_count => '1',
  :memory_size=> '1536',
  :video_memory_size=> '32',
  :os_type_id => 'Windows8_64',
  :iso_download_instructions => "Download and install full featured software for 180-day trial at http://technet.microsoft.com/en-US/evalcenter/hh670538.aspx",
  :iso_file => "9600.16384.WINBLUE_RTM.130821-1623_X64FRE_SERVER_EVAL_EN-US-IRM_SSS_X64FREE_EN-US_DV5.ISO",
  :iso_md5 => "458ff91f8abc21b75cb544744bf92e6a",
  :iso_src => "http://care.dlservice.microsoft.com/dl/download/6/2/A/62A76ABB-9990-4EFC-A4FE-C7D698DAEB96/9600.16384.WINBLUE_RTM.130821-1623_X64FRE_SERVER_EVAL_EN-US-IRM_SSS_X64FREE_EN-US_DV5.ISO",
  :iso_download_timeout => '1800',
  :disk_size => '30420', :disk_format => 'VDI', :hostiocache => 'on',
  :floppy_files => [ 'Autounattend.xml', 'oracle-cert.cer' ],
  :boot_wait => '3',
  :boot_cmd_sequence => [''],
  :kickstart_port => '7122',
  :winrm_user => 'vagrant',
  :winrm_password => 'vagrant',
  :postinstall_timeout => '10000',
  :postinstall_files => [
    'install-chocolatey.bat', 'run-chocolatey.bat',
    'install-chef.bat', 'update-gems.bat', 'run-chef.bat',
    'install-vbox.bat',
    'do-reboot.bat'
  ],
  # No sudo on windows
  :sudo_cmd => '%f',
  :shutdown_cmd => 'shutdown /s /t 10 /f /d p:4:1 /c "Shutdown"',
  :virtualbox => {
    # required for 'blue' architecture
    :extradata => 'VBoxInternal/CPUM/CMPXCHG16B 1',
    :vm_options => [
      'audio' => 'null',
      # 'audio' => 'coreaudio',
      # 'audiocontroller' => 'hda',
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
