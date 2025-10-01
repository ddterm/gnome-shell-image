#!/bin/bash

set -ex

source /etc/os-release

locked_packages=(
    "gnome-shell-$GNOME_SHELL_VERSION"
    "mutter-$MUTTER_VERSION"
    "gjs-$GJS_VERSION"
    "typelib-1_0-Vte-2_91-$VTE_VERSION"
    "typelib-1_0-Vte-3_91-$VTE_VERSION"
)

packages=(
    "${locked_packages[@]}"
    systemd-sysvinit
    xorg-x11-server-Xvfb
    gdm
    gnome-session-wayland
    gnome-extensions
    gtk3-metatheme-adwaita
    typelib-1_0-Handy-1_0
    wl-clipboard
)

zypper --non-interactive install --no-recommends -f "${packages[@]}"

for pkg in "${locked_packages[@]}"
do
    rpm -q "$pkg"
done

zypper clean --all
