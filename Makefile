site:
	cd roles/site_node/files/syncthing && gpg-zip --decrypt syncthing_config_dir
	sops -d group_vars/secrets.yml > group_vars/secrets.dec.yml
	-ansible-playbook -i group_vars/site.yml -i group_vars/secrets.dec.yml -l servers $(options) -K playbook_site.yml
	rm -f group_vars/secrets.dec.yml
	rm -rf roles/site_node/files/config

init:
	sudo apt update
	sudo apt install software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible
	sudo apt install ansible

ping-servers:
	ansible servers -i group_vars/site.yml -m ping

apt-upgrade-servers:
	ansible servers -i group_vars/site.yml -m apt -K -ba "upgrade=yes update_cache=yes"

check-need-reboot:
	ansible servers -i group_vars/site.yml -m command -K -ba "bat /var/run/reboot-required"

reboot-servers:
	ansible servers -i group_vars/site.yml -m command -K -ba "reboot"

shutdown-servers:
	ansible servers -i group_vars/site.yml -m command -K -ba "shutdown now"

local:
	ansible-playbook --connection=local -i group_vars/site.yml -l local $(options) -K playbook_local.yml
