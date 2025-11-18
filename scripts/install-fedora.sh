#!/bin/bash

set -ex

source /etc/os-release

locked_packages=(
    "gnome-shell-$GNOME_SHELL_VERSION"
    "mutter-$MUTTER_VERSION"
    "gjs-$GJS_VERSION"
    "vte291-$VTE_VERSION"
    "vte291-gtk4-$VTE_VERSION"
)

packages=(
    "${locked_packages[@]}"
    gnome-extensions-app
    gdm
    mesa-dri-drivers
    wl-clipboard
    libhandy
)

if [ "$ID" = fedora ]; then
    packages+=(xorg-x11-server-Xvfb)

    if (( VERSION_ID < 43 )); then
        packages+=(gnome-session-xsession)
    fi
fi

if [ "$ID" = centos ]; then
    dnf config-manager --set-enabled crb
    dnf install -y epel-release
fi

dnf install -y --nodocs --setopt install_weak_deps=False "${packages[@]}"

for pkg in "${locked_packages[@]}"
do
    rpm -q "$pkg"
done

dnf clean all -y
