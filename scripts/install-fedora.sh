#!/bin/bash

set -ex

locked_packages=(
    "gnome-shell-$GNOME_SHELL_VERSION"
    "mutter-$MUTTER_VERSION"
    "gjs-$GJS_VERSION"
)

packages=(
    "${locked_packages[@]}"
    gnome-session-xsession
    gnome-extensions-app
    gdm
    vte291
    vte291-gtk4
    xorg-x11-server-Xvfb
    mesa-dri-drivers
    wl-clipboard
    libhandy
)

dnf install -y --nodocs --setopt install_weak_deps=False "${packages[@]}"

for pkg in "${locked_packages[@]}"
do
    rpm -q "$pkg"
done

dnf clean all -y
