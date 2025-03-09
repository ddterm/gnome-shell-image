#!/bin/bash

set -ex

systemctl set-default multi-user.target
systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2
chmod u+rw /etc/shadow
truncate --size 0 /etc/machine-id
