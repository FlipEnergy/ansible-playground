site:
	cd roles/site_node/files/syncthing && gpg-zip --decrypt syncthing_config_dir
	make dec-secrets
	-ansible-playbook -i group_vars/site.yml -i group_vars/secrets.dec.yml $(options) -K playbook_site.yml
	make del-dec-secrets
	rm -rf roles/site_node/files/config

local:
	ansible-playbook --connection=local -i group_vars/site.yml $(options) -K playbook_local.yml

sandbox:
	make dec-secrets
	ansible-playbook -i group_vars/site.yml -i group_vars/secrets.dec.yml $(options) -K playbook_sandbox.yml
	make del-dec-secrets

dec-secrets:
	sops -d group_vars/secrets.yml > group_vars/secrets.dec.yml

del-dec-secrets:
	rm -f group_vars/secrets.dec.yml

init:
	wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
	python3.8 /tmp/get-pip.py
	python3.8 -m pip install -vvv --user ansible==4.2.0

ping:
	ansible servers -i group_vars/site.yml -m ping

apt-upgrade-servers:
	ansible servers -i group_vars/site.yml -m apt -K -ba "upgrade=yes update_cache=yes"

check-need-reboot:
	ansible servers -i group_vars/site.yml -m command -K -ba "bat /var/run/reboot-required"

reboot-servers:
	ansible servers -i group_vars/site.yml -m command -K -ba "reboot"

shutdown-servers:
	ansible servers -i group_vars/site.yml -m command -K -ba "shutdown now"
