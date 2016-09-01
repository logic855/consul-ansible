sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install -y ansible
sudo cp /vagrant/.vagrant/machines/web01/virtualbox/private_key /root/.ssh/web01
sudo cp /vagrant/.vagrant/machines/web02/virtualbox/private_key /root/.ssh/web02
sudo cp /vagrant/.vagrant/machines/web03/virtualbox/private_key /root/.ssh/web03

sudo cp /vagrant/hosts /etc/ansible/hosts
sudo chmod 0600 /root/.ssh/web*

sudo cp /vagrant/known_hosts /root/.ssh/known_hosts
sudo chmod 0640 /root/.ssh/known_hosts