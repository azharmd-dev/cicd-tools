#!/bin/bash
set -xe

# Install required packages (NO full system update)

dnf install -y java-17-openjdk wget unzip cloud-utils-growpart lvm2

# ===== Disk Resize =====

growpart /dev/nvme0n1 4
pvresize /dev/nvme0n1p4

# Give all extra space to /var (best for SonarQube)

lvextend -l +100%FREE /dev/mapper/RootVG-varVol
xfs_growfs /var

# ===== Add Swap (important for small EC2 instances) =====

fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# ===== Install SonarQube =====

cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.6.0.92116.zip
unzip sonarqube-*.zip
mv sonarqube-* sonarqube


useradd sonar
chown -R sonar:sonar /opt/sonarqube

# Start SonarQube

sudo -u sonar /opt/sonarqube/bin/linux-x86-64/sonar.sh start
