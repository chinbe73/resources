#!/bin/sh
. $(dirname $0)/set_env.sh.inc
multipass launch --name $MP_HOST --cpus 4 --mem 6g --disk 100g
multipass start $MP_HOST
if [ "$USERDOMAIN" == "VISANA" ]; then
    multipass transfer $(dirname $0)/resources/install_proxy.sh $MP_HOST:
    multipass transfer $(dirname $0)/resources/*.crt $MP_HOST:
    multipass exec $MP_HOST sh install_proxy.sh
    multipass exec $MP_HOST rm install_proxy.sh
    DOMAIN_SUFFIX=.visana.intra
else
    DOMAIN_SUFFIX=
fi
multipass transfer $(dirname $0)/resources/install_vm.sh $MP_HOST:
multipass exec $MP_HOST sh install_vm.sh "$(cat ~/.ssh/id_rsa.pub 2> /dev/null)"
multipass exec $MP_HOST rm install_vm.sh
multipass exec $MP_HOST sudo cat /etc/rancher/k3s/k3s.yaml | sed s/127.0.0.1/${MP_HOST}${DOMAIN_SUFFIX}/ > ~/.kube/config-$MP_HOST
$(dirname $0)/set_network.sh
