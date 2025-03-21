#!/bin/sh

set -ex

locked_packages="
    gnome-shell=$GNOME_SHELL_VERSION
    mutter=$MUTTER_VERSION
    gjs=$GJS_VERSION
"

packages="
    $locked_packages
    xvfb
    xinit
    elogind
    polkit-elogind
    mesa
    mesa-dri-gallium
    gdm
    vte3
    vte3-gtk4
    libhandy1
    wl-clipboard
"

apk add $packages

for pkg in $locked_packages
do
    apk info -e "$pkg"
done

rm -rf /var/cache/apk/*
