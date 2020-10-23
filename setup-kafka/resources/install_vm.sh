set -x
# Init
mkdir -p ~/.local/bin
KAFKA_DATA=$HOME/data
# Add SSH Key
if [ -z "$(grep -F "$1" ~/.ssh/authorized_keys)" ]; then
    echo $1 >> ~/.ssh/authorized_keys
fi
# Install K3s
k3s -v
if [ $? -ne 0 ]; then
    curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -
fi
# Aliases, Funtions and Completions
cat << EOF > ~/.bash_aliases
. <(kubectl completion bash)
alias k='kubectl'
complete -F __start_kubectl k
function kns () { kubectl config set-context --current --namespace=\$1; }
EOF
# Install Java 8 & 11
sudo apt update
sudo apt install -y openjdk-8-jdk openjdk-11-jdk
# Install Kafka
if [ ! -d "$HOME/kafka" ]; then
    curl -sfL https://downloads.apache.org/kafka/2.6.0/kafka_2.13-2.6.0.tgz | tar xz -C ~
    ln -s ~/kafka_2.13-2.6.0 ~/kafka
fi
if [ -z "$(grep kafka/bin ~/.profile)" ]; then
    echo PATH=\$PATH:$HOME/kafka/bin >> ~/.profile
fi
mkdir -p $KAFKA_DATA
sed -i "s@\(dataDir=\).*@\1$KAFKA_DATA/zookeeper@" ~/kafka/config/zookeeper.properties
sed -i "s@\(log.dirs=\).*@\1$KAFKA_DATA/kafka@" ~/kafka/config/server.properties
# Install Kafka start/stop Scripts
cat << EOF > ~/.local/bin/k-start
#/bin/sh
if [ \$(ps -elf | grep $HOME/kafka/config/zookeeper.properties | grep -v grep | wc -l) -eq 0 ]; then
    zookeeper-server-start.sh $HOME/kafka/config/zookeeper.properties > $KAFKA_DATA/zookeeper.log &
fi
if [ \$(ps -elf | grep $HOME/kafka/config/server.properties | grep -v grep | wc -l) -eq 0 ]; then
    kafka-server-start.sh $HOME/kafka/config/server.properties > $KAFKA_DATA/server.log &
    tail -n +1 -f $KAFKA_DATA/server.log
else
    tail -f $KAFKA_DATA/server.log
fi
EOF
cat << EOF > ~/.local/bin/k-stop-server
#/bin/sh
ps -elf | grep $HOME/kafka/config/server.properties | grep -v grep | awk '{print \$4}' | xargs kill -15 &> /dev/null
EOF
cat << EOF > ~/.local/bin/k-stop-zookeeper
#/bin/sh
ps -elf | grep $HOME/kafka/config/zookeeper.properties | grep -v grep | awk '{print \$4}' | xargs kill -15 &> /dev/null
EOF
cat << EOF > ~/.local/bin/k-stop
#/bin/sh
\$(dirname \$0)/k-stop-server
sleep 5
\$(dirname \$0)/k-stop-zookeeper
EOF
cat << EOF > ~/.local/bin/k-delete
#/bin/sh
\$(dirname \$0)/k-stop
rm -rf $KAFKA_DATA/*
EOF
# Install Conduktor
if [ ! -f "$HOME/.local/bin/conduktor" ]; then
    cd ~
    curl -sfL https://releases.conduktor.io/linux-zip | jar xf /dev/stdin
    find ~ -maxdepth 1 -name conduktor-* -exec ln -s {}/bin/conduktor ~/.local/bin/conduktor \;
fi
# Install Kafdrop
if [ ! -f "$HOME/.local/bin/kafdrop" ]; then
    mkdir -p ~/kafdrop-3.27.0
    curl -sfL https://bintray.com/obsidiandynamics/kafdrop/download_file?file_path=com%2Fobsidiandynamics%2Fkafdrop%2Fkafdrop%2F3.27.0%2Fkafdrop-3.27.0.jar -o ~/kafdrop-3.27.0/kafdrop.jar
    cat << EOF > ~/.local/bin/kafdrop
#/bin/sh
java --add-opens=java.base/sun.nio.ch=ALL-UNNAMED -jar $HOME/kafdrop-3.27.0/kafdrop.jar
EOF
fi
# Finish
chmod u+x ~/.local/bin/*
