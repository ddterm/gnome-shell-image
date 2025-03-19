#!/bin/bash

set -ex

packages=(
    "gnome-shell=$GNOME_SHELL_VERSION"
    "mutter=$MUTTER_VERSION"
    dbus-daemon-units
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

pacman -Q "gnome-shell=$GNOME_SHELL_VERSION"
pacman -Q "mutter=$MUTTER_VERSION"

pacman -Scc --noconfirm
