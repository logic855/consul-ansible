Hashicorp Vault, AWS KMS, Chef/Ansible Vault, Consul [Hack Session]
-------------------------------------------------------------------

***Maintainer***
[Thanassis Zografos](mailto:tzografos@gmail.com)
August 2016

for [devstaff.gr](https://www.devstaff.gr)

----------

***Files Included***
This is a basic first version without any refctoring or special coding style.

Hard coded values exist.

Future versions will make this tutotrial more flexible.

***Files Included***
```
|-- Playbooks
        |-- consul_add_disk_usage_check.yml
        |-- consul_add_kv1.yml
        |-- consul_add_kv2.yml
        |-- consul_add_nginx_service.yml
        |-- consul_agent.j2
        |-- consul_agent.yml
        |-- consul_kv_ask.yml
       	|-- consul_remove_kv1.yml
       	|-- consul_server.j2
       	|-- consul_server.yml
        |-- consul_ui_nginx.yml
        |-- default.conf
        |-- disk_usage.py
        |-- supervisor_agent.j2
        |-- supervisor_server.j2   
        |-- supervisord.yml
        |-- vault_test.yml
        |-- vaulted.yml                
|-- Scripts
       	|-- ansible.sh
|-- Vagrantfile
|-- hosts
|-- known_hosts
|-- README.md
```

----------

***Example Flow***

First step is to bring up the full infra
```
vagrant up
```
Initially lets login to `ansiblemaster` switch to root
```
vagrant ssh ansiblemaster
sudo -i
```
quick test is to run the following in order to check connectivity with all systems
```
ansible -m ping all
```

If everything is ok you should see something like:
```
web01 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
web02 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
web03 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
...
```
In case of a problem and receiving the following:
```
web02 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh.",
    "unreachable": true
}
web03 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh.",
    "unreachable": true
}
web01 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh.",
    "unreachable": true
}
```
Then do this:
Clear all contents of `known_hosts`
```
echo "" > ~/.ssh/known_hosts
```
Then log in to all three server separately:
```
ssh -i web01 vagrant@192.168.10.101
ssh -i web02 vagrant@192.168.10.102
ssh -i web03 vagrant@192.168.10.103
```
Run again :
```
ansible -m ping all
```
and get all green.

----------

In order to install supervisor, to control the consul service we do:
```
ansible-playbook /vagrant/Playbooks/supervisord.yml
```
In order to install consul server we do:
```
ansible-playbook /vagrant/Playbooks/consul_server.yml
```

In order to install consul agents we do:

```
ansible-playbook /vagrant/Playbooks/consul_agent.yml
```
To test our consul cluster we can do in any of the servers:
```
/opt/consul members
```
which if everything is ok shall result in:
```
Node   Address              Status  Type    Build  Protocol  DC
web01  192.168.10.101:8301  alive   server  0.6.4  2         herakliongr
web02  192.168.10.102:8301  alive   client  0.6.4  2         herakliongr
web03  192.168.10.103:8301  alive   client  0.6.4  2         herakliongr
```

At this point we have a cluster with 3 vms, one server and 2 agents.

---
Let's install nginx so we can actually view the consul UI live on any one of the agents, like so:
```
ansible-playbook /vagrant/Playbooks/consul_ui_nginx.yml
```
If all is well you should see upon visiting any of the IPs of the 2 agents the consul UI.

Lets try this [http://192.168.10.102/#/herakliongr/nodes](http://192.168.10.102/#/herakliongr/nodes) and see what happens

---
Lets add a service check by:
```
ansible-playbook /vagrant/Playbooks/consul_add_nginx_service.yml
```

-------
To add a key/value pair just do the following:
```
ansible-playbook /vagrant/Playbooks/consul_add_kv1.yml
```
To add a second
```
ansible-playbook /vagrant/Playbooks/consul_add_kv2.yml
```
To remove the first
```
ansible-playbook /vagrant/Playbooks/consul_remove_kv1.yml
```
Finaly ask for one:
```
ansible-playbook /vagrant/Playbooks/consul_kv_ask.yml --extra-vars "target=web02"
```
