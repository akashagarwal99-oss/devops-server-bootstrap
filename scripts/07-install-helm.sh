#!/bin/bash

############################################################
# Script : 07-install-helm.sh
# Purpose: Install Helm
#
# Official Documentation:
# https://helm.sh/docs/intro/install/
############################################################

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

print_header "Installing Helm"

if check_command helm; then
    log_success "Helm is already installed."
    helm version
    exit 0
fi

log_info "Downloading official Helm installer..."

curl -fsSL -o get_helm.sh \
https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

log_info "Installing Helm..."

./get_helm.sh

log_info "Cleaning temporary files..."

rm -f get_helm.sh

log_success "Helm installed successfully."

helm version
