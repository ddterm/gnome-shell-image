#!/bin/bash

set -ex

source /etc/os-release

# https://wiki.ubuntu.com/Testing/EnableProposed

cat <<EOF >"/etc/apt/sources.list.d/ubuntu-$VERSION_CODENAME-proposed.list"
# Enable Ubuntu proposed archive
deb http://archive.ubuntu.com/ubuntu/ $VERSION_CODENAME-proposed restricted main multiverse universe
EOF
