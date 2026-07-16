#!/bin/bash

############################################################
# Script : 08-install-eksctl.sh
# Purpose: Install eksctl
#
# Official Documentation:
# https://eksctl.io/installation/
############################################################

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

print_header "Installing eksctl"

if check_command eksctl; then
    log_success "eksctl is already installed."
    eksctl version
    exit 0
fi

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

log_info "Downloading latest eksctl release..."

curl --silent --location \
"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz" \
| tar xz -C /tmp

log_info "Installing eksctl..."

sudo install -m 0755 /tmp/eksctl /usr/local/bin

rm -f /tmp/eksctl

log_success "eksctl installed successfully."

eksctl version
