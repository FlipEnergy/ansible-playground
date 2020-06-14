#!/bin/bash
# get latest release here: https://github.com/DNSCrypt/dnscrypt-proxy/releases

cd /opt
wget https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.0.44/dnscrypt-proxy-linux_arm-2.0.44.tar.gz
tar xzvf dnscrypt-proxy-linux_arm-2.*.tar.gz
mv -vf linux-arm dnscrypt-proxy
rm -vf dnscrypt-proxy-linux_arm-2.*.tar.gz

cd dnscrypt-proxy
cp example-dnscrypt-proxy.toml dnscrypt-proxy.toml

echo "continue install here: https://github.com/pi-hole/pi-hole/wiki/DNSCrypt-2.0"
