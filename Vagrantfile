Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.synced_folder ".", "/srv/"

  config.vm.provider "virtualbox" do |vb|
    vb.name = 'example-webapp'
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y language-pack-en
    apt-get install -y redis-server rabbitmq-server docker.io postgresql
    usermod -aG docker vagrant
    echo 'cd /srv' >> /home/vagrant/.bashrc
    cd /srv
    docker build . -t webapp --network host
    sudo su postgres -c psql < makedb.sql
    docker run --rm --net=host webapp ./manage.py migrate
  SHELL
end
