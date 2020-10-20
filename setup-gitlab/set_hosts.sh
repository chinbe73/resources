#!/bin/sh
. $(dirname $0)/set_env.sh.inc
IP=$(multipass exec $MP_HOST -- ip addr | grep -E "(eth0|enp0s8)$" | sed 's/^ .* inet \(.*\)\/.*$/\1/')
echo IP: $IP
echo Update C:\\Windows\\System32\\drivers\\etc\\hosts
echo '#########################'
if [ "$USERDOMAIN" == "VISANA" ]; then
    echo $IP $MP_HOST $MP_HOST.visana.intra
fi
echo '#########################'
