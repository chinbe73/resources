set -x
grep -Fq 'http_proxy=' /etc/environment
if [ $? -ne 0 ]; then
    sudo sed -i '$ahttp_proxy=http://www-proxy.visana.ch:8080' /etc/environment
    sudo sed -i '$ahttps_proxy=http://www-proxy.visana.ch:8080' /etc/environment
    sudo sed -i '$ano_proxy=localhost,127.0.0.1,.visana.ch,.visana.intra' /etc/environment
fi
sudo mv ~/*.crt /usr/local/share/ca-certificates
sudo update-ca-certificates
