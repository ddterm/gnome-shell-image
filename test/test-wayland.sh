#!/usr/bin/env bash

if [[ $# != 1 ]]; then
    echo "Usage: $0 image-name" >&2
    exit 1
fi

SCRIPT_DIR=$(CDPATH="" cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

function shutdown {
    podman exec "$CID" systemctl list-units --failed || true
    podman rm -f "$CID"
}

SHARED_DIR="$(mktemp -d)"

ENV_VARS=(
    "XDG_RUNTIME_DIR=${SHARED_DIR}/runtime"
    "XDG_CONFIG_HOME=${SHARED_DIR}/config"
    "XDG_CACHE_HOME=${SHARED_DIR}/cache"
    "XDG_STATE_HOME=${SHARED_DIR}/state"
    "XDG_DATA_HOME=${SHARED_DIR}/data"
    "DBUS_SESSION_BUS_ADDRESS=unix:path=${SHARED_DIR}/runtime/bus"
    "NO_AT_BRIDGE=1"
    "GTK_A11Y=none"
)

mkdir -m 0700 -v "${SHARED_DIR}/runtime" "${SHARED_DIR}/config" "${SHARED_DIR}/cache" "${SHARED_DIR}/state" "${SHARED_DIR}/data"

UID="$(id -u)"

set -ex

CAPS="SYS_ADMIN,SYS_NICE,SYS_PTRACE,SETPCAP,NET_RAW,NET_BIND_SERVICE,IPC_LOCK"
CID="$(podman create --log-driver=none --tty --cap-add="$CAPS" --security-opt=label=disable --user=0 --userns=keep-id -v "$SHARED_DIR:$SHARED_DIR" "$1")"

trap shutdown EXIT

podman start --attach --sig-proxy=false "$CID" &
podman wait --condition=running "$CID"
podman exec "$CID" busctl --watch-bind=true status
podman exec "$CID" systemctl is-system-running --wait

podman exec "--user=$UID" "${ENV_VARS[@]/#/--env=}" "$CID" dbus-daemon --session --nopidfile --syslog --fork "--address=unix:path=${SHARED_DIR}/runtime/bus"
podman exec "--user=$UID" "${ENV_VARS[@]/#/--env=}" "$CID" busctl --user --watch-bind=true status
env "${ENV_VARS[@]}" dbus-send --session --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.Peer.Ping

podman exec "--user=$UID" "${ENV_VARS[@]/#/--env=}" "$CID" gnome-shell --wayland --headless --sm-disable --unsafe-mode --virtual-monitor 1600x960 &

while ! env "${ENV_VARS[@]}" dbus-send --session --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep '"org.gnome.Shell.Screenshot"'
do
    sleep 1
done

while env "${ENV_VARS[@]}" dbus-send --session --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval 'string:Main.layoutManager._startingUp' | grep 'string "true"'
do
    sleep 1
done

env "${ENV_VARS[@]}" dbus-send --session --print-reply --dest=org.gnome.Shell.Screenshot /org/gnome/Shell/Screenshot org.gnome.Shell.Screenshot.Screenshot 'boolean:true' 'boolean:false' "string:${SHARED_DIR}/screenshot-wayland.png"
cp "${SHARED_DIR}/screenshot-wayland.png" "${SCRIPT_DIR}/"
