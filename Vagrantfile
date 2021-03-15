Vagrant.configure("2") do |config|

    # Settings
    VIRTUALBOX_NAME="Lamp Development"
    MYSQL_ROOT_PASSWORD='mysql'
    PHP_VERSION='7.4' # 7.4|8.0

    config.vm.box = "ubuntu/focal64"

    config.vm.network "forwarded_port", guest: 80, host: 8080
    #config.vm.network "forwarded_port", guest: 3306, host: 3306

    config.vm.synced_folder "./", "/var/www/html"
    config.vm.provision "file", source: "./build/vagrant_setup/apache/000-default.conf", destination: "/home/vagrant/000-default.conf"
    config.vm.provision "shell", path: "./build/vagrant_setup/provision.sh", env: {"MYSQL_ROOT_PASSWORD" => MYSQL_ROOT_PASSWORD, "PHP_VERSION" => PHP_VERSION}

    config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.name = VIRTUALBOX_NAME
        vb.memory = 2048
        vb.cpus = 2
   end
end
