#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
echo "========================================="
echo "DevOps Server Bootstrap"
echo "========================================="

for script in \
    scripts/01-system-update.sh \
    scripts/02-install-java.sh \
    scripts/03-install-docker.sh \
    scripts/04-install-jenkins.sh \
    scripts/05-install-aws-cli.sh \
    scripts/06-install-kubectl.sh \
    scripts/07-install-helm.sh \
    scripts/08-install-eksctl.sh \
    scripts/09-verify-installation.sh
do
    if [ -f "$SCRIPT_DIR/$script" ]; then
        bash "$SCRIPT_DIR/$script"
    else
        echo "Skipping $script (not found)"
    fi
done

echo
echo "========================================="
echo "Bootstrap Completed Successfully"
echo "========================================="
