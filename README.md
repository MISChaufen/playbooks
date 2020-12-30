## MISChaufen ansible playbooks


## Preparation

1. issue an SSH key
2. bootstrap a server
3. note the servers IP and put it into the file `hosts`
4. configure the groups vars in directory `group_var`
5. login into the remote server as root
6. run all commands in file `helper/remote_prepare.sh` on the remote server as root


## Run the Deployment

```
make deploy
```

After the first deployment you SSHD key signature on server side changes. So that you have to cleanup your local `~/.ssh/known_hosts` file.
