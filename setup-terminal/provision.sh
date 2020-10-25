# Upgrade and install common
apt update && apt upgrade -y && apt install -y apt-transport-https bash-completion net-tools
# Install kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt update && apt install -y kubectl
kubectl completion bash > /etc/profile.d/kubectl_completion.sh
# Install oc
curl -Lso /dev/stdout https://github.com/openshift/okd/releases/download/4.5.0-0.okd-2020-10-15-235428/openshift-client-linux-4.5.0-0.okd-2020-10-15-235428.tar.gz | tar xz -C /usr/bin oc
oc completion bash > /etc/profile.d/oc_completion.sh
# Upgrade second time (needed?)
#apt upgrade -y
# Configure user home of user vagrant
cat | sudo -u vagrant bash <<'EOF1'
# Link folders
ln -s ~/Home/git ~/git
ln -s ~/Home/.kube ~/.kube
# Add Windows users ssh public key to authorized_keys
if [ -f ~/Home/.ssh/id_rsa.pub ]; then cat ~/Home/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; fi
# Disable background color for other-writable folders
dircolors -p | sed "s/^STICKY_OTHER_WRITABLE 30\;42/STICKY_OTHER_WRITABLE 30\;44/;s/^OTHER_WRITABLE 34\;42/OTHER_WRITABLE 34\;40/" > ~/.dircolors
# Disable welcome message
#touch ~/.hushlogin
# Create bash_aliases (aliases, functions and more)
cat > ~/.bash_aliases <<'EOF2'
alias k='kubectl'
alias wd='if [ -f ~/Home/.dir ]; then cd $(cat ~/Home/.dir | sed s@~@$HOME@); fi'
complete -F __start_kubectl k
function kns () { kubectl config set-context --current --namespace=\$1; }
if [ -f ~/Home/.bash_profile ]; then . ~/Home/.bash_profile; fi
wd
EOF2
EOF1
