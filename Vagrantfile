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
