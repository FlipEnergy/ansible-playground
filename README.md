# Ansible-Playground
Repo for my Ansible stuff.

# requirements
Ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu
Sops (installed with Helm Secrets plugin): https://github.com/mozilla/sops

# Installing Ansible
```
make
```

# set up local machine
```
make local
```

# Setup my site
```
make site

# or with options to the ansible-playbook command

make site options='-l kubernetes -v'
```
