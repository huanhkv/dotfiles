#!/bin/bash
set -e

OS_ID=$(awk -F= '/^ID=/{print $2}' /etc/os-release 2>/dev/null | tr -d '"' || echo "")

if [ "$(uname -s)" == "Darwin" ]; then
    echo "Setting for Mac OS X"
    sh setup-macos.sh
elif [ "$OS_ID" == "debian" ]; then
    echo "Setting for Debian"
    sh setup-debian.sh
elif [ "$OS_ID" == "fedora" ]; then
    echo "Setting for Fedora"
    sh setup-fedora.sh
else
    echo "Unknown OS, not installing dependencies"
fi
