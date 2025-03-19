#!/bin/bash

set -ex

source /etc/os-release

locked_packages=(
    "gnome-shell-$GNOME_SHELL_VERSION"
    "mutter-$MUTTER_VERSION"
    "gjs-$GJS_VERSION"
)

packages=(
    "${locked_packages[@]}"
    systemd-sysvinit
    xorg-x11-server-Xvfb
    gdm
    gnome-session-wayland
    gnome-extensions
    gtk3-metatheme-adwaita
    typelib-1_0-Vte-2.91
    typelib-1_0-Vte-3_91
    typelib-1_0-Handy-1_0
    wl-clipboard
)

if [ "$ID" = "opensuse-tumbleweed" ]
then
    packages+=(gnome-session-xsession)
fi

zypper --non-interactive install --no-recommends -f "${packages[@]}"

for pkg in "${locked_packages[@]}"
do
    rpm -q "$pkg"
done

zypper clean --all
