#!/bin/sh

set -ex

rc-update add elogind
rc-update add polkit
sed -i '/getty/d' /etc/inittab
