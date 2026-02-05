#!/bin/bash
set -xe

dnf install -y java-17-openjdk wget unzip cloud-utils-growpart lvm2

growpart /dev/nvme0n1 4
pvresize /dev/nvme0n1p4

lvextend -L +10G /dev/mapper/RootVG-rootVol
xfs_growfs /

lvextend -l +100%FREE /dev/mapper/RootVG-varVol || true
xfs_growfs /var || true

fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.6.0.92116.zip
unzip sonarqube-*.zip
mv sonarqube-10.6.0.92116 sonarqube

useradd sonar
chown -R sonar:sonar /opt/sonarqube

sudo -u sonar /opt/sonarqube/bin/linux-x86-64/sonar.sh start
