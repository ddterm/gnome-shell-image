#!/bin/bash

set -ex

source /etc/os-release

packages=(
    "gnome-shell=$GNOME_SHELL_VERSION"
    "mutter=$MUTTER_VERSION"
    "gjs=$GJS_VERSION"
    gnome-session
    dbus-user-session
    gdm3
    gir1.2-vte-2.91
    xvfb
    wl-clipboard
    gir1.2-handy-1
)

if [ "$ID" == ubuntu ]
then
    packages+=(ubuntu-desktop-minimal)
fi

if [ "$UBUNTU_CODENAME" != jammy ]
then
    packages+=(gir1.2-vte-3.91)
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y --no-install-recommends "${packages[@]}"

test "$(dpkg-query --showformat='${Version}' --show gnome-shell)" = "$GNOME_SHELL_VERSION"
test "$(dpkg-query --showformat='${Version}' --show mutter)" = "$MUTTER_VERSION"
test "$(dpkg-query --showformat='${Version}' --show gjs)" = "$GJS_VERSION"
