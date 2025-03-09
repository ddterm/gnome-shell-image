#!/bin/sh

set -ex

apk add \
    xvfb \
    xinit \
    elogind \
    polkit-elogind \
    mesa \
    mesa-dri-gallium \
    gnome-shell \
    gdm \
    vte3 \
    vte3-gtk4 \
    libhandy1 \
    wl-clipboard \

rm -rf /var/cache/apk/*

rc-update add elogind
rc-update add polkit
sed -i '/getty/d' /etc/inittab
