#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

print_header "Installing Jenkins LTS"

# Verify Java
if ! check_command java; then
    log_error "Java is not installed. Run 02-install-java.sh first."
    exit 1
fi

log_info "Installing Jenkins prerequisites..."

sudo apt-get update
sudo apt-get install -y fontconfig openjdk-21-jre

log_info "Creating apt keyrings directory..."

sudo mkdir -p /etc/apt/keyrings

log_info "Downloading Jenkins GPG key..."

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

log_info "Adding Jenkins repository..."

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

log_info "Updating package index..."

sudo apt-get update

log_info "Installing Jenkins..."

sudo apt-get install -y jenkins

log_info "Enabling Jenkins..."

sudo systemctl enable jenkins

log_info "Starting Jenkins..."

sudo systemctl start jenkins

log_info "Waiting for Jenkins service..."

sleep 10

if systemctl is-active --quiet jenkins; then
    log_success "Jenkins is running."
else
    log_error "Jenkins failed to start."
    sudo systemctl status jenkins --no-pager
    exit 1
fi

log_info "Adding Jenkins user to Docker group..."

sudo usermod -aG docker jenkins

log_success "Jenkins installation completed."

echo
echo "==========================================="
echo "Jenkins URL"
echo "http://$(curl -s http://checkip.amazonaws.com):8080"
echo "==========================================="

echo
echo "Initial Admin Password:"
echo "-------------------------------------------"

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "-------------------------------------------"
