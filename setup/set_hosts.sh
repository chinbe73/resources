#!/bin/sh
NAME=gitops
IP=$(multipass exec $NAME -- ip addr | grep eth0$ | sed 's/^ .* inet \(.*\)\/.*$/\1/')
echo IP: $IP
echo Update C:\\Windows\\System32\\drivers\\etc\\hosts
echo '#########################'
echo $IP $NAME
echo $IP demo.info
echo $IP argocd.info
echo '#########################'
