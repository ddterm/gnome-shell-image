#!/bin/sh

set -ex

apk add \
    xvfb \
    xinit \
    elogind \
    polkit-elogind \
    mesa \
    mesa-dri-gallium \
    "gnome-shell=$GNOME_SHELL_VERSION" \
    "mutter=$MUTTER_VERSION" \
    "gjs=$GJS_VERSION" \
    gdm \
    vte3 \
    vte3-gtk4 \
    libhandy1 \
    wl-clipboard \

apk info -e "gnome-shell=$GNOME_SHELL_VERSION"
apk info -e "mutter=$MUTTER_VERSION"
apk info -e "gjs=$GJS_VERSION"

rm -rf /var/cache/apk/*

rc-update add elogind
rc-update add polkit
sed -i '/getty/d' /etc/inittab
