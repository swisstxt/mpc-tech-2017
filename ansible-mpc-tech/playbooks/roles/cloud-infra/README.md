Role for managing a SWISS TXT cloud projects
============================================

This role managed an CloudStack Advanced Zone setup similar to SWISS TXT cloud.

Requirements
------------

See http://docs.ansible.com/ansible/guide_cloudstack.html for a up to date guide about setup and dependencies.

Role Variables
--------------

~~~yaml
# Which cloudstack zone to use, default: None (first zone found).
cs_zone: null

# Which cloudstack project to use, default: None
cs_project: null

# Which cloudstack domain to use, default: None
cs_domain: null

# Which cloudstack region to use, default: cloudstack
cs_region: "cloudstack"

# Which IP should be assigned to the VM, default: None
cs_public_ip: ""

# When cs_public_ip is set and cs_portforwarding_rules is not empty, port
# forwarding are configured instead of a static NAT, e.g.:
# cs_portforwarding_rules:
# - { public_port: 21, private_port: 21, protocol: tcp }
cs_portforwarding_rules: []

# When cs_public_ip is set configure these firewall rules, e.g.:
# cs_firewall_rules:
# - { start_port: 21, end_port: 21, protocol: tcp, cidr: 10.10.100.0/22 }
cs_firewall_rules: []

# What networks to use
cs_networks: null
cs_ip_networks: null

# If a change would need to restart the VM,
# "cs_force: true" would restart the VM
cs_force: false

# What offering to use
cs_offering: 1cpu_1gb

# What template to use
cs_template: CentOS-7-x86_64

# Set "cs_disk: true" for additional data disk
cs_disk: false
cs_disk_offering: "Perf STXT"
cs_disk_size: 100

# Check for SSH reachabilty using this host.
cs_jumphost: localhost
~~~

Example Playbook
----------------

Inventory:
~~~ini
[jump]
jump-01.example.com  cs_public_ip=10.10.10.10 ansible_host=10.10.10.10

[webservers]
web-01.example.com  cs_public_ip=10.10.10.100
~~~

Webservers group variables:
~~~yaml
# file: group_vars/webservers
cs_portforwarding_rules:
  - { public_port: 80 }
  - { public_port: 443 }
  - { public_port: 2322, protocol: udp }

cs_firewall_rules:
  - { start_port: 80, end_port: 80, protocol: tcp }
  - { start_port: 443, end_port: 443, protocol: tcp }
  - { start_port: 2322, end_port: 2322, protocol: udp, cidr: 10.100.10.0/22 }

cs_networks:
  - Server Network
  - Storage Network
~~~

Jump host group variables:
~~~yaml
# file: group_vars/jump
cs_portforwarding_rules:
  - { public_port: 22 }

cs_firewall_rules:
  - { start_port: 22, end_port: 22, protocol: tcp, cidr: 10.100.10.0/22 }
~~~

The cloud playbook:
~~~yaml
# file: cloud.yml
- name: install jump hosts in the cloud
  hosts: jump
  gather_facts: no
  roles:
  - cloud-infra

- name: install VMs in the cloud
  hosts: all:!jump
  gather_facts: no
  roles:
  - cloud-infra
~~~

License
-------

BSD

Author Information
------------------

René Moser, SWISS TXT
