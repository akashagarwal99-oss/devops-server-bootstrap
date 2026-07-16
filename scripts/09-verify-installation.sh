#!/bin/bash

############################################################
# Script : 09-verify-installation.sh
# Purpose: Verify all installed DevOps tools
############################################################

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

print_header "DevOps Server Verification"

check_tool() {
    local display_name="$1"
    local binary_name="$2"
    local version_command="$3"

    if command -v "$binary_name" >/dev/null 2>&1; then
        printf "✅ %-18s %s\n" "$display_name" "$(eval "$version_command")"
    else
        printf "❌ %-18s Not Installed\n" "$display_name"
    fi
}

############################################################
# Installed Tools
############################################################

check_tool "Java" "java" "java -version 2>&1 | head -1"

check_tool "Git" "git" "git --version"

check_tool "Docker" "docker" "docker --version"

check_tool "Docker Compose" "docker" "docker compose version"

check_tool "AWS CLI" "aws" "aws --version"

check_tool "kubectl" "kubectl" "kubectl version --client"

check_tool "Helm" "helm" "helm version --short"

check_tool "eksctl" "eksctl" "eksctl version"

echo

############################################################
# Jenkins Status
############################################################

if systemctl is-active --quiet jenkins; then
    echo "✅ Jenkins Service   Running"
else
    echo "❌ Jenkins Service   Not Running"
fi

echo

############################################################
# Docker Group Checks
############################################################

if groups "$USER" | grep -qw docker; then
    echo "✅ Current User      In docker group"
else
    echo "❌ Current User      Not in docker group"
fi

if id jenkins >/dev/null 2>&1; then
    if groups jenkins | grep -qw docker; then
        echo "✅ Jenkins User      In docker group"
    else
        echo "❌ Jenkins User      Not in docker group"
    fi
else
    echo "❌ Jenkins User      Does not exist"
fi

echo

############################################################
# Public IP
############################################################

echo "========================================="
echo "Public IP"
curl -s https://checkip.amazonaws.com
echo "========================================="
