local:
	time ansible-playbook --connection=local $(options) -K local.yml

site:
	time ansible-playbook -i group_vars/site.yml $(options) -K site.yml
