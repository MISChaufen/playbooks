

help:                     ## printing out the help
	@echo
	@echo MISChaufen Ansible Playbooks
	@echo
	@echo --- TARGETS ---
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'



deploy:                     ## deploying using ansible playbooks
	ansible-playbook -i ./hosts site.yml
