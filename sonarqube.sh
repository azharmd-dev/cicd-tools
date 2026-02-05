#!/bin/bash
set -xe

# Update system

dnf update -y
dnf install -y java-17-openjdk wget unzip cloud-utils-growpart

# Resize disk

growpart /dev/nvme0n1 4
pvresize /dev/nvme0n1p4
lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -L +5G /dev/mapper/RootVG-rootVol
lvextend -l +100%FREE /dev/mapper/RootVG-homeVol
xfs_growfs /
xfs_growfs /var
xfs_growfs /home

# Add swap

fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Install SonarQube

cd /opt
wget [https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.6.0.92116.zip](https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.6.0.92116.zip)
unzip sonarqube-*.zip
mv sonarqube-* sonarqube

useradd sonar
chown -R sonar:sonar /opt/sonarqube

sudo -u sonar /opt/sonarqube/bin/linux-x86-64/sonar.sh start
