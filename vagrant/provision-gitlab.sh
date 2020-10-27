# Install K3s
k3s -v && curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" K3S_KUBECONFIG_MODE="644" sh -
kubectl completion bash > /etc/profile.d/kubectl_completion.sh
# Configure user home of user vagrant
cat | sudo -u vagrant bash <<'EOF1'
# Add ssh public key of Windows user to authorized_keys
if [ -f ~/Home/.ssh/id_rsa.pub ]; then cat ~/Home/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; fi
# Link folders
ln -s ~/Home/git ~/git
# Configure Git
for name in core.autocrlf core.longpaths push.default user.email user.name; do
  if [ "\$(git config -f ~/Home/.gitconfig --get \$name)" ]; then git config --global \$name "\$(git config -f ~/Home/.gitconfig --get \$name)"; fi
done
git config --global credential.helper store
# Disable background color for other-writable folders
dircolors -p | sed "s/^STICKY_OTHER_WRITABLE 30\;42/STICKY_OTHER_WRITABLE 30\;44/;s/^OTHER_WRITABLE 34\;42/OTHER_WRITABLE 34\;40/" > ~/.dircolors
# Disable welcome message
touch ~/.hushlogin
# Create .bash_aliases (aliases, functions and more)
cat > ~/.bash_aliases <<'EOF2'
alias k='kubectl'
complete -F __start_kubectl k
function kns () { kubectl config set-context --current --namespace=\$1; }
if [ -f ~/Home/.bash_profile ]; then . ~/Home/.bash_profile; fi
EOF2
# Copy K3s config
cat /etc/rancher/k3s/k3s.yaml | sed s/127.0.0.1/\$(hostname -s).visana.intra/ > ~/Home/.kube/config-\$(hostname -s)
EOF1
