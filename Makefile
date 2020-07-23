init:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible

apt-upgrade-servers:
	ansible servers -i group_vars/site.yml -m apt -K -ba "upgrade=yes update_cache=yes"

ping-servers:
	ansible servers -i group_vars/site.yml -m ping

reboot-servers:
	ansible servers -i group_vars/site.yml -m command -K -ba "reboot"

shutdown-servers:
	ansible servers -i group_vars/site.yml -m command -K -ba "shutdown now"

local:
	ansible-playbook --connection=local -i group_vars/site.yml -l localhost $(options) -K local.yml

site:
	cd roles/site_node/files && gpg-zip --decrypt ~/k8s-home-lab/syncthing/syncthing_config
	sops -d group_vars/secrets.yml > group_vars/secrets.dec.yml
	-ansible-playbook -i group_vars/site.yml -i group_vars/secrets.dec.yml -l servers $(options) -K site.yml
	rm -f group_vars/secrets.dec.yml
	rm -rf roles/site_node/files/config
