#!/bin/bash
#
# Script Name : 03-install-docker.sh
# Purpose     : Install Docker CE on Ubuntu
# Author      : Akash Agarwal
# Repository  : devops-server-bootstrap
#

set -euo pipefail

echo "==========================================="
echo "Installing Docker CE"
echo "==========================================="

# Check if Docker is already installed
if command -v docker >/dev/null 2>&1; then
    echo "Docker is already installed."
    docker --version
    exit 0
fi

echo "Removing old Docker packages (if any)..."

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
do
    sudo apt-get remove -y $pkg || true
done

echo "Installing prerequisites..."

sudo apt-get update

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg

echo "Adding Docker GPG key..."

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "Adding Docker repository..."

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

echo "Installing Docker..."

sudo apt-get install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

echo "Starting Docker service..."

sudo systemctl enable docker
sudo systemctl start docker

echo "Adding current user to docker group..."

sudo usermod -aG docker $USER

echo ""
echo "==========================================="
echo "Docker Installed Successfully"
echo "==========================================="

docker --version

echo ""
echo "IMPORTANT:"
echo "Logout and login again (or reconnect SSH)"
echo "for Docker group permissions to take effect."
