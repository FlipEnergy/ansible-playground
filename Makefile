python := python3

site:
	make dec-secrets
	-python3 -m ansible playbook -i group_vars/site.yml -i group_vars/secrets.dec.yml $(options) -K playbook_site.yml
	make del-dec-secrets

local:
	make dec-secrets
	python3 -m ansible playbook --connection=local -i group_vars/site.yml -i group_vars/secrets.dec.yml $(options) -K playbook_local.yml
	make del-dec-secrets

dec-secrets:
	sops -d group_vars/secrets.yml > group_vars/secrets.dec.yml

del-dec-secrets:
	rm -f group_vars/secrets.dec.yml

init:
	sudo apt-get install python3-pip -y
	$(python) -m pip install --user ansible==6.2.0

ping:
	ANSIBLE_HOST_KEY_CHECKING=False python3 -m ansible adhoc servers -i group_vars/site.yml $(options) -m ping

neofetch-servers:
	python3 -m ansible adhoc servers -i group_vars/site.yml $(options) -m command -a "neofetch"

apt-upgrade-servers:
	python3 -m ansible adhoc servers -i group_vars/site.yml $(options) -m apt -K -ba "upgrade=yes update_cache=yes"

check-need-reboot:
	python3 -m ansible adhoc servers -i group_vars/site.yml $(options) -m command -K -ba "bat /var/run/reboot-required"

reboot-servers:
	python3 -m ansible adhoc servers -i group_vars/site.yml $(options) -m command -K -ba "reboot"

shutdown-servers:
	python3 -m ansible adhoc servers -i group_vars/site.yml $(options) -m command -K -ba "shutdown now"
