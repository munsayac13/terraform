#!/bin/bash

WORKDIR=/tmp

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
apt upgrade --yes

echo "Install AWS CLI ..."
cd $WORKDIR
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

echo "Install AZURE CLI ..."
curl -L https://aka.ms/InstallAzureCli | /bin/bash
