#!/bin/bash

set -euo pipefail

echo "==========================================="
echo "Updating Ubuntu Packages"
echo "==========================================="

sudo apt update
sudo apt upgrade -y

echo ""
echo "Installing common utilities..."

sudo apt install -y \
curl \
wget \
git \
unzip \
zip \
ca-certificates \
gnupg \
lsb-release \
software-properties-common \
apt-transport-https

echo ""
echo "Cleaning package cache..."

sudo apt autoremove -y
sudo apt autoclean

echo ""
echo "==========================================="
echo "System Update Completed Successfully"
echo "==========================================="
