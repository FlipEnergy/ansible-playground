local:
	time ansible-playbook --connection=local $(options) -K local.yml

site:
	cd roles/site_node/files && gpg-zip --decrypt ~/k8s-home-lab/syncthing/syncthing_config
	time ansible-playbook -i group_vars/site.yml $(options) -K site.yml
	rm -rf roles/site_node/files/config
