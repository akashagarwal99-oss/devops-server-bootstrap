#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

print_header "Installing AWS CLI v2"

if check_command aws; then
    log_success "AWS CLI is already installed."
    aws --version
    exit 0
fi

log_info "Downloading AWS CLI..."

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

log_info "Extracting..."

unzip -q awscliv2.zip

log_info "Installing..."

sudo ./aws/install

log_info "Cleaning temporary files..."

rm -rf aws awscliv2.zip

log_success "AWS CLI installed successfully."

aws --version
