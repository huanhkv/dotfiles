#!/bin/bash
set -e

if [ "$(uname -s)" == "Darwin" ]; then
    echo "Setting for Mac OS X"
    sh setup-macos.sh
elif [ ""$(awk -F= '/^ID_LIKE/{print $2}' /etc/os-release | tr -d '"') == "debian" ]; then
    echo "Setting for Debian"
    sh setup-debian.sh
else
    echo "Unknown OS, not installing dependencies"
fi
