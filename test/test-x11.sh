#!/usr/bin/env bash

if [[ $# != 1 ]]; then
    echo "Usage: $0 image-name" >&2
    exit 1
fi

SCRIPT_DIR=$(CDPATH="" cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

function shutdown {
    podman exec "$CID" sh -c 'if command -v systemctl; then systemctl list-units --failed; else rc-status -a; fi' || true
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
podman exec "$CID" gdbus wait --system --timeout=60 org.freedesktop.login1

podman exec "--user=$UID" "${ENV_VARS[@]/#/--env=}" "$CID" dbus-daemon --session --nopidfile --syslog --fork "--address=unix:path=${SHARED_DIR}/runtime/bus"
env "${ENV_VARS[@]}" dbus-send --session --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.Peer.Ping

mkfifo "${SHARED_DIR}/display_pipe"
podman exec "--user=$UID" "${ENV_VARS[@]/#/--env=}" "$CID" sh -c "Xvfb -screen 0 1600x960x24 -nolisten tcp -displayfd 3 3>'${SHARED_DIR}/display_pipe'" &

read -r DISPLAY_NUMBER <"${SHARED_DIR}/display_pipe"

podman exec "--user=$(id -u)" "${ENV_VARS[@]/#/--env=}" "--env=DISPLAY=:$DISPLAY_NUMBER" "$CID" gnome-shell --x11 --sm-disable --unsafe-mode &

env "${ENV_VARS[@]}" gdbus wait --session --timeout=60 org.gnome.Shell.Screenshot

while env "${ENV_VARS[@]}" dbus-send --session --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval 'string:Main.layoutManager._startingUp' | grep 'string "true"'
do
    sleep 1
done

env "${ENV_VARS[@]}" dbus-send --session --print-reply --dest=org.gnome.Shell.Screenshot /org/gnome/Shell/Screenshot org.gnome.Shell.Screenshot.Screenshot 'boolean:true' 'boolean:false' "string:${SHARED_DIR}/screenshot-x11.png"
cp "${SHARED_DIR}/screenshot-x11.png" "${SCRIPT_DIR}/"
