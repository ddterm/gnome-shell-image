#!/bin/bash

set -ex

packages=(
    dbus-daemon-units
    gnome-shell
    vte3
    vte4
    xorg-server-xvfb
    xorg-xinit
    mesa
    gdm
    wl-clipboard
    libhandy
)

pacman -Rdd --noconfirm dbus-broker-units
pacman -Syu --noconfirm "${packages[@]}"
pacman -Scc --noconfirm
