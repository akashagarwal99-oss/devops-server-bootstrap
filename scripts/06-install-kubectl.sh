#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

print_header "Installing kubectl"

if check_command kubectl; then
    log_success "kubectl is already installed."
    kubectl version --client
    exit 0
fi

log_info "Downloading latest kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

log_info "Downloading checksum..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

log_info "Verifying checksum..."

echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

log_info "Installing kubectl..."

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

log_info "Cleaning temporary files..."

rm -f kubectl kubectl.sha256

log_success "kubectl installed successfully."

kubectl version --client
