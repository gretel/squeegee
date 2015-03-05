# https://github.com/WinRb/vagrant-windows
Vagrant.configure(2) do |config|
  config.vm.box = "winbox.box"
  config.vm.guest = :windows
  config.windows.set_work_network = true
  config.vm.network :forwarded_port, guest: 3389, host: 3389
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
end
