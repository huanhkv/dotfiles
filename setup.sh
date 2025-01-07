#!/bin/bash
set -e

if [ "$(uname -s)" == "Darwin" ]; then
    sh ./setup-masos.sh
elif [ ""$(awk -F= '/^ID_LIKE/{print $2}' /etc/os-release | tr -d '"') == "debian" ]; then
    echo "Debian"
    sh ./setup-debian.sh
else
    echo "Unknown OS, not installing dependencies"
fi
