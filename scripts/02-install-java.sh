#!/bin/bash
#
# Script Name : 02-install-java.sh
# Purpose     : Install OpenJDK 21
# Author      : Akash Agarwal
# Repository  : devops-server-bootstrap
#

set -euo pipefail

echo "==========================================="
echo "Installing OpenJDK 21"
echo "==========================================="

if command -v java >/dev/null 2>&1; then
    echo "Java is already installed."
    java -version
    exit 0
fi

sudo apt update
sudo apt install -y openjdk-21-jdk

echo ""
echo "Verifying Java Installation..."

java -version

echo ""
echo "==========================================="
echo "Java Installed Successfully"
echo "==========================================="
