# Nightwire's, Nerd-Kino's and MISChaufen's ansible playbooks

A set of playbooks to maintain our servers.

## How to run a play

```bash
Usage:
  ./tools/run_playbook.sh <-p path/to/playbook> [-l <limit>] [--install-requirements] [-b]

	-p,	--playbook
			Path to playbook directory, relative to repo root
	-l,	--limit
			Limit playboot to specific hosts or groups
			e.g.: "-l host0,host1,group0,group1"
	-b,	--bootstrap
			Bootstrap Server. This is for Server where the base role was never executed on.
		--install-requirements
			Install ansible-galaxy requirements
```

## Plabook structure

[![plabook structure and dependencies][nomnomlimg]][nomnoml]

```
#titel: nomnoml

#direction: right
#.play: visual=note
#.dir: fill=#878787 stroke=#f2f2f2 dashed
#.roleapp: fill=#eb4034
#.rolesystem: fill=#c2c2c2

[<dir> nerd_kino]
[<dir> rclone_web_ui]
[<dir> verlihub]

[<package> nerd_kino/inventory|
  - nerd-kino.de
]
[<package> rclone_web_ui/inventory|
  - rclone.nerd-kino.de
]
[<package> verlihub/inventory|
  - desert-combat.gsh-lan.net
]

[<play> nerd_kino/bootstrap.yml]
[<play> nerd_kino/upgrade.yml]
[<play> nerd_kino/plabook.yml]
[<play> rclone_web_ui/bootstrap.yml]
[<play> rclone_web_ui/upgrade.yml]
[<play> rclone_web_ui/plabook.yml]
[<play> verlihub/bootstrap.yml]
[<play> verlihub/upgrade.yml]
[<play> verlihub/plabook.yml]

[<rolesystem> shokinn.system.ubuntu.base]
[<rolesystem> shokinn.system.ubuntu.base.rpi]
[<rolesystem> shokinn.system.ubuntu.base.x86_64_server]
[<rolesystem> shokinn.system.ubuntu.base.x86_64_server.apu2c4]
[<rolesystem> shokinn.system.dhparam]

[shokinn.system.ubuntu.base.rpi]-->[shokinn.system.ubuntu.base]
[shokinn.system.ubuntu.base.x86_64_server]-->[shokinn.system.ubuntu.base]
[shokinn.system.ubuntu.base.x86_64_server.apu2c4]-->[shokinn.system.ubuntu.base]

[<roleapp> shokinn.app.iptables]
[<roleapp> shokinn.app.nginx.cert.helper]
[<roleapp> nginxinc.nginx]
[<roleapp> nginxinc.nginx_config.git]
[<roleapp> stefangweichinger.rclone]
[<roleapp> geerlingguy.pip]
[<roleapp> geerlingguy.certbot]
[<roleapp> clutterbox.ansible-dehydrated]
[<roleapp> fluepke.app.powerdns_authoritative]
[<roleapp> shokinn.app.config.docker]
[<roleapp> shokinn.system.ubuntu.livepatch]

[nginxinc.nginx]-->[shokinn.system.dhparam]
[shokinn.app.nginx.cert.helper]-->[geerlingguy.certbot]

[verlihub/inventory]-[verlihub]
[verlihub]->[verlihub/bootstrap.yml]
[verlihub]->[verlihub/upgrade.yml]
[verlihub/bootstrap.yml]->[verlihub/plabook.yml]
[verlihub/upgrade.yml]->[verlihub/plabook.yml]
[verlihub/plabook.yml]->[shokinn.system.ubuntu.base.rpi]
[verlihub/plabook.yml]->[shokinn.app.iptables]

[nerd_kino/inventory]-[nerd_kino]
[nerd_kino]->[nerd_kino/bootstrap.yml]
[nerd_kino]->[nerd_kino/upgrade.yml]
[nerd_kino/bootstrap.yml]->[nerd_kino/plabook.yml]
[nerd_kino/upgrade.yml]->[nerd_kino/plabook.yml]
[nerd_kino/plabook.yml]->[shokinn.system.ubuntu.base.x86_64_server]
[nerd_kino/plabook.yml]->[shokinn.app.iptables]

[rclone_web_ui/inventory]-[rclone_web_ui]
[rclone_web_ui]->[rclone_web_ui/bootstrap.yml]
[rclone_web_ui]->[rclone_web_ui/upgrade.yml]
[rclone_web_ui/bootstrap.yml]->[rclone_web_ui/plabook.yml]
[rclone_web_ui/upgrade.yml]->[rclone_web_ui/plabook.yml]
[rclone_web_ui/plabook.yml]->[shokinn.system.ubuntu.base.x86_64_server]
[rclone_web_ui/plabook.yml]->[shokinn.app.iptables]
[rclone_web_ui/plabook.yml]->[geerlingguy.pip]
[rclone_web_ui/plabook.yml]->[shokinn.app.nginx.cert.helper]
[rclone_web_ui/plabook.yml]->[nginxinc.nginx]
[rclone_web_ui/plabook.yml]->[stefangweichinger.rclone]

```

## Naming scheme

### Roles

```
          Role which will install/configure a/n program/app.
          |
username.<app|system>.role_name
              |
              Role which will configure the system.
```

## Useful commands

### Encrypt variables with Ansible Vault

```bash
ansible-vault encrypt_string --vault-id @prompt 'string_to_encrypt' --name 'the_secret'
```

### Encrypt files with Ansible Vault

```bash
ansible-vault encrypt <file>
```

### Debug a variable

```yaml
- name: debug
  debug:
    var: variable_to_debug
```

### End playbook here

```yml
- meta: end_play
```

### pre requiements

Install requirements from ansible galaxy:  
```bash
ansible-galaxy install -r "./requirements.yml"
```

### Run a playbook with ansible vault

```bash
ansible-playbook --vault-id @prompt -i ./inventory ./[bootstrap|site].yml
```

### Run a playbook with ansible vault but limit a specific host

```bash
ansible-playbook --vault-id @prompt -i ./inventory --limit <inventory_name_of_host_or_name_of_group> ./[bootstrap|site].yml
```

## Upload folder via rsync to server

```bash
rsync -avzh ../playbooks user@host.tld:~/
```

## Known issues

### python fork bug

#### Bug
  
```
objc[53614]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called.
objc[53614]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called. We cannot safely call it or ignore it in the fork() child process. Crashing instead. Set a breakpoint on objc_initializeAfterForkError to debug.
```

#### Fix

```bash
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```

[nomnoml]: http://www.nomnoml.com/
[nomnomlimg]: ./nomnoml.svg
