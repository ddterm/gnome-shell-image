#!/bin/bash

set -ex

source /etc/os-release

packages=(
    systemd-sysvinit
    xorg-x11-server-Xvfb
    gjs
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
    zypper --non-interactive install --no-recommends gnome-session-xsession
fi

zypper --non-interactive install --no-recommends "${packages[@]}"
zypper clean --all
