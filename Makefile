

help:                     ## printing out the help
	@echo
	@echo MISChaufen Ansible Playbooks
	@echo
	@echo --- TARGETS ---
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean:                    ## cleanup all temporary/work data
	rm -rf .venv

bootstrap:                ## prepare local environment
	sudo ./helper/local_prepare.sh
	./helper/bootstrap.sh

local.deploy:             ## local deployment using ansible playbooks
	ansible-playbook -i ./hosts -l local local.site.yml

test.deploy:              ## test deployment using ansible playbooks
	ansible-playbook -i ./hosts -l test_benni_tech site.yml

prod.deploy:              ## prod deployment using ansible playbooks
	ansible-playbook -i ./hosts -l prod_benni_tech site.yml

home.deploy:              ## home deployment using ansible playbooks
	ansible-playbook -i ./hosts -l home site.yml

deploy:                   ## deployment using ansible playbooks
	ansible-playbook -i ./hosts site.yml
