ARG base_image=ubuntu-24.04

FROM docker.io/library/debian:12@sha256:27586f4609433f2f49a9157405b473c62c3cb28a581c413393975b4e8496d0ab AS debian-12
FROM docker.io/library/debian:trixie@sha256:4b826db5f1f14d1db0b560304f189d4b17798ddce2278b7822c9d32313fe3f50 AS debian-13
FROM docker.io/library/ubuntu:22.04@sha256:58b87898e82351c6cf9cf5b9f3c20257bb9e2dcf33af051e12ce532d7f94e3fe AS ubuntu-22.04
FROM docker.io/library/ubuntu:24.04@sha256:b359f1067efa76f37863778f7b6d0e8d911e3ee8efa807ad01fbf5dc1ef9006b AS ubuntu-24.04
FROM docker.io/library/ubuntu:24.10@sha256:c62f1babc85f8756f395e6aabda682acd7c58a1b0c3bea250713cd0184a93efa AS ubuntu-24.10

FROM ${base_image}

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gnome-session \
        gjs \
        dbus-user-session \
        gdm3 \
        gir1.2-vte-2.91 \
        xvfb \
        packagekit \
        gir1.2-packagekitglib-1.0 \
        wl-clipboard \
        gir1.2-handy-1

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

CMD [ "/sbin/init" ]
