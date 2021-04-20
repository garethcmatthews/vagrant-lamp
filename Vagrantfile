Vagrant.configure("2") do |config|

    # Settings
    VIRTUALBOX_NAME="Lamp Development"
    MYSQL_ROOT_PASSWORD='mysql'
    PHP_VERSION='7.4' # 7.4|8.0

    config.vm.box = "ubuntu/focal64"

    config.vm.network "forwarded_port", guest: 80, host: 8080
    #config.vm.network "forwarded_port", guest: 3306, host: 3306

    config.vm.boot_timeout = 300
    config.vm.synced_folder "./", "/var/www/html"
    config.vm.provision "file", source: "./build/vagrant-lamp/apache/000-default.conf", destination: "/home/vagrant/000-default.conf"
    config.vm.provision "shell", path: "./build/vagrant-lamp/provision.sh", env: {"MYSQL_ROOT_PASSWORD" => MYSQL_ROOT_PASSWORD, "PHP_VERSION" => PHP_VERSION}
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
        vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
        vb.gui = false
        vb.name = VIRTUALBOX_NAME
        vb.memory = 2048
        vb.cpus = 2
   end
end
