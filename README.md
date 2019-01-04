# 404notfoundhard_infra
404notfoundhard Infra repository

bastion_IP=35.207.140.251
someinternalhost_IP=10.156.0.3

### one line connect
```
ssh -i /home/user/.ssh/gcp_appUser.pub gcp_appUser@10.156.0.3 -o "proxycommand ssh -W %h:%p -i /home/user/.ssh/gcp_appUser.pub gcp_appUser@35.207.140.2"
```
#
additional task
#

#### first case
```
alias 2bastion='ssh -i /home/user/.ssh/gcp_appUser.pub gcp_appUser@35.207.140.251'
alias 2interalgcp='ssh -i /home/user/.ssh/gcp_appUser.pub gcp_appUser@10.156.0.3 -o "proxycommand ssh -W %h:%p -i /home/user/.ssh/gcp_appUser.pub gcp_appUser@35.207.140.2"'

funcsave 2bastion
funcsave 2internalgcp
```
#### second case
```
Host 35.207.140.251
  Hostname 35.207.140.251
  User gcp_appUser
  IdentityFile  ~/.ssh/gcp_appUser.pub
Host 10.156.0.*
  IdentityFile  ~/.ssh/gcp_appUser.pub
  User gcp_appUser
  ProxyCommand ssh -W %h:%p  gcp_appUser@35.207.140.251
```

