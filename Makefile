local:
	ansible-playbook --connection=local $(options) -K local.yml

site:
	ansible-playbook -i group_vars/site.yml $(options) -K site.yml
