

help:                     ## printing out the help
	@echo
	@echo MISChaufen Ansible Playbooks
	@echo
	@echo --- TARGETS ---
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

bootstrap:                ## prepare local environment
	python -m env .venv
	source .venv/bin/acticate
	pip install -U -r requirements.txt

test-deploy:              ## test deployment using ansible playbooks
	ansible-playbook -i ./hosts -l private-test site.yml

deploy:                   ## deployment using ansible playbooks
	ansible-playbook -i ./hosts site.yml
