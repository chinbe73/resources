#!/bin/sh
DIR=$(dirname $0)
. $DIR/set_env.sh.inc
multipass launch --name $MP_HOST --cloud-init - << EOF
ssh_authorized_keys:
  - $(cat ~/.ssh/id_rsa.pub 2> /dev/null)
ca-certs:
  trusted: 
  - |
    $(cat $DIR/resources/visana-machine-v3.crt | sed '2,$s/^/    /')
  - |
    $(cat $DIR/resources/visana-root-v3.crt | sed '2,$s/^/    /')
  - |
    $(cat $DIR/resources/www-proxy-rtc.visana.ch-2019.crt | sed '2,$s/^/    /')
  - |
    $(cat $DIR/resources/www-proxy-wp.visana.ch-2019.crt | sed '2,$s/^/    /')
package_update: true
package_upgrade: true
apt:
  http_proxy: http://www-proxy.visana.ch:8080
  https_proxy: http://www-proxy.visana.ch:8080
packages:
- sshfs
- net-tools
- apt-transport-https
write_files:
- content: |
    set -e
    sed -i '\$ahttp_proxy=http://www-proxy.visana.ch:8080' /etc/environment
    sed -i '\$ahttps_proxy=http://www-proxy.visana.ch:8080' /etc/environment
    sed -i '\$ano_proxy=localhost,127.0.0.1,.visana.ch,.visana.intra' /etc/environment
    dircolors -p | sed "s/^STICKY_OTHER_WRITABLE 30\;42/STICKY_OTHER_WRITABLE 30\;44/;s/^OTHER_WRITABLE 34\;42/OTHER_WRITABLE 34\;40/" > /etc/dircolors
    echo 'eval \$(dircolors /etc/dircolors)' >> /etc/profile
    echo 'eval \$(dircolors /etc/dircolors)' >> /etc/bash.bashrc
  path: /init.sh
  permissions: '0500'
bootcmd:
- ifconfig enp0s8 $MP_IP netmask 255.255.255.0 up
runcmd:
- systemctl disable systemd-timesyncd
- /init.sh && rm /init.sh
EOF

#root@gitlab:/var/lib/cloud/instance# cat vendor-data.txt
##cloud-config
#growpart:
#  mode: auto
#  devices: [/]
#  ignore_growroot_disabled: false
#users:
#  - default
#manage_etc_hosts: true
#ssh_authorized_keys:
#  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3JL3CrjVPEQ/5a5hxN2YmUbCvOcPlrEQAq43oWEl5R+qaKdhkzbRkyyDpyQ0MofyeiDO1nRn187/A+Uz2m4/IIMCkeziKeIVkTLXilrC/emrbo3ZRcrFotrKUrinZ6/vPed046+ZRcQDJtri/4KT1piUt6FW3Xe41dycfYBhvfPsT2+mDKeoXmvPq/+6hPkCjWjgCNPzZK7D/G+L4NvQC/m34P4NGVR2NkA6ubUt8rarEOs4mOJDJVmN5lztro8I6VWtq8lR5dnHDsC0VhN3bVre9qTn+Bj1xslCvI/3foeJp5t1NfuSLEu2t+adVkegpDWEWQ7Ug97FImmgv5RwN ubuntu@localhost
#timezone: Europe/Zurich
#system_info:
#  default_user:
#    name: ubuntu
#write_files:
#  - path: /etc/pollinate/add-user-agent
#    content: "multipass/version/1.4.0+win # written by Multipass\nmultipass/driver/virtualbox # written by Multipass\nmultipass/host/windows-10 # written by Multipass\n"

