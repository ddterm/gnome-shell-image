#!/bin/bash

set -ex

locked_packages=(
    "gnome-shell${GNOME_SHELL_VERSION:+=$GNOME_SHELL_VERSION}"
    "mutter${MUTTER_VERSION:+=$MUTTER_VERSION}"
    "gjs${GJS_VERSION:+=$GJS_VERSION}"
    "vte3${VTE_VERSION:+=$VTE_VERSION}"
    "vte4${VTE_VERSION:+=$VTE_VERSION}"
)

packages=(
    "${locked_packages[@]}"
    dbus-daemon-units
    xorg-server-xvfb
    xorg-xinit
    mesa
    gdm
    wl-clipboard
    libhandy
)

pacman -Rdd --noconfirm dbus-broker-units
pacman -Syu --noconfirm "${packages[@]}"

for pkg in "${locked_packages[@]}"
do
    pacman -Q "$pkg"
done

pacman -Scc --noconfirm
