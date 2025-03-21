#!/bin/bash

set -ex

source /etc/os-release

locked_packages=(
    "gnome-shell=$GNOME_SHELL_VERSION"
    "mutter=$MUTTER_VERSION"
    "gjs=$GJS_VERSION"
)

packages=(
    "${locked_packages[@]}"
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

for pkg in "${locked_packages[@]}"
do
    test "${pkg}" = "$(dpkg-query --showformat='${Package}=${Version}' --show "${pkg%=*}")"
done
