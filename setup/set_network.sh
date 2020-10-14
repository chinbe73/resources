#!/bin/sh
. $(dirname $0)/set_env.sh.inc
IP=$(multipass exec $MP_HOST -- ip addr | grep -E "(eth0|enp0s8)$" | sed 's/^ .* inet \(.*\)\/.*$/\1/')
if [ -z $IP ]; then
    multipass stop $MP_HOST
    echo 'Execute in admin power shell (Press any key when ready):'
    echo 'psexec64 -s "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "'$MP_HOST'" --nic2 hostonly --hostonlyadapter2 "VirtualBox Host-Only Ethernet Adapter"' | tee /dev/tty | clip
    read
    multipass start $MP_HOST
    multipass exec $MP_HOST -- sudo apt install -y net-tools
    multipass exec $MP_HOST sudo ifconfig enp0s8 $MP_IP netmask 255.255.255.0 up
fi
$(dirname $0)/set_hosts.sh
