#!/bin/bash

set -ex

packages=(
    gnome-session-xsession
    gnome-extensions-app
    gjs
    gdm
    vte291
    vte291-gtk4
    xorg-x11-server-Xvfb
    mesa-dri-drivers
    wl-clipboard
    libhandy
)

dnf install -y --nodocs --setopt install_weak_deps=False "${packages[@]}"
dnf clean all -y
