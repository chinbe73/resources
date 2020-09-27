#!/bin/sh
NAME=gitops
multipass launch --name $NAME --cpus 4 --mem 6g --disk 100g
multipass start $NAME
multipass transfer $(dirname $0)/install_vm.sh $NAME:
multipass exec $NAME sh install_vm.sh "$(cat ~/.ssh/id_rsa.pub 2> /dev/null)"
multipass exec $NAME rm install_vm.sh
multipass exec $NAME sudo cat /etc/rancher/k3s/k3s.yaml | sed s/127.0.0.1/$NAME/ > ~/.kube/config
$(dirname $0)/set_hosts.sh
