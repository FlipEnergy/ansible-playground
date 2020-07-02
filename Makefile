init:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible

local:
	time ansible-playbook --connection=local $(options) -K local.yml

site:
	cd roles/site_node/files && gpg-zip --decrypt ~/k8s-home-lab/syncthing/syncthing_config
	sops -d group_vars/secrets.yml > group_vars/secrets.dec.yml
	time ansible-playbook -i group_vars/site.yml -i group_vars/secrets.dec.yml  $(options) -K site.yml
	rm -f group_vars/secrets.dec.yml
	rm -rf roles/site_node/files/config
