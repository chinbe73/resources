```
    "terminal.integrated.shellArgs.windows": [
        "--login",
        "-i",
        "-c",
        "echo ${PWD/#$HOME/\\~} > ~/.dir; multipass shell"
    ],
    "terminal.integrated.shell.windows": "C:\\scoop\\apps\\git\\current\\bin\\bash.exe",

sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
mkdir -p ~/.local/bin
curl https://github.com/openshift/okd/releases/download/4.5.0-0.okd-2020-10-15-235428/openshift-client-linux-4.5.0-0.okd-2020-10-15-235428.tar.gz -Lo /dev/stdout | tar xz -C ~/.local/bin oc
ln -s ~/Home/git ~/git
ln -s ~/Home/.kube ~/.kube
dircolors -p | sed "s/^STICKY_OTHER_WRITABLE 30\;42/STICKY_OTHER_WRITABLE 30\;44/;s/^OTHER_WRITABLE 34\;42/OTHER_WRITABLE 34\;40/" > ~/.dircolors
echo source ~/Home/.bash_profile >> ~/.profile
echo 'cd $(cat ~/Home/.dir | sed s@~@$HOME@)' >> ~/.profile
```
