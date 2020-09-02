multipass launch --name gitops --cpus 4 --mem 6g --disk 100g
multipass exec gitops -- bash -c 'curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" K3S_KUBECONFIG_MODE="644" sh -'
multipass exec gitops sudo cat /etc/rancher/k3s/k3s.yaml | sed s/127.0.0.1/demo.info/ > ~/.kube/config
IP=$(multipass exec gitops -- ip addr | grep eth0$ | sed 's/^ .* inet \(.*\)\/.*$/\1/')
echo IP: $IP
echo Update C:\\Windows\\System32\\drivers\\etc\\hosts
echo '#########################'
echo $IP demo.info
echo $IP theia
echo '#########################'
