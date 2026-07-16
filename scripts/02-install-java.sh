#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

print_header "Installing OpenJDK 21"

if check_command java; then
    log_success "Java is already installed."
    java -version
    exit 0
fi

log_info "Installing OpenJDK 21..."

sudo apt update
sudo apt install -y openjdk-21-jdk

log_info "Verifying installation..."

java -version

log_success "Java installed successfully."
