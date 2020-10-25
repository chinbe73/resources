set -x
# Add SSH Key
if [ -z "$(grep -F "$1" ~/.ssh/authorized_keys)" ]; then
    echo $1 >> ~/.ssh/authorized_keys
fi
# Install K3s
k3s -v
if [ $? -ne 0 ]; then
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" K3S_KUBECONFIG_MODE="644" sh -
fi
# Aliases, Funtions and Completions
cat << EOF > ~/.bash_aliases
. <(kubectl completion bash)
alias k='kubectl'
complete -F __start_kubectl k
function kns () { kubectl config set-context --current --namespace=\$1; }
EOF
