#!/bin/bash

echo "Set timezone to US Central ..."
timedatectl set-timezone America/Chicago

echo "Set Hostname to ${hostname} ..."
hostnamectl set-hostname ${hostname}

cat <<EOF > /etc/hosts
# This file is auto generated
127.0.0.1 localhost
$IPV4 ${hostname}
192.168.44.129 NodeOne.local NodeOne
192.168.44.131 NodeTwo.local NodeTwo
192.168.44.133 NodePostgres.local NodePostgres
EOF

echo "Update apt cache ..."
apt update

echo "Install Components ..."
apt install vim gzip tar curl wget unzip tmux dnsutils systemd
apt upgrade
