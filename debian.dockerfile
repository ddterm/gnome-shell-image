ARG base_image=ubuntu-24.04

FROM docker.io/library/debian:12@sha256:e11072c1614c08bf88b543fcfe09d75a0426d90896408e926454e88078274fcb AS debian-12
FROM docker.io/library/debian:trixie@sha256:4bf4a3ee5cd9a4a6bc048af9bf7c0666f761e391e7ebb158b3da554ffe75994e AS debian-13
FROM docker.io/library/ubuntu:24.04@sha256:d4f6f70979d0758d7a6f81e34a61195677f4f4fa576eaf808b79f17499fd93d1 AS ubuntu-24.04
FROM docker.io/library/ubuntu:24.10@sha256:3f49af910ce126ee3d7d1982fe57e34cc90265cb9ac2db3f9e7166e2c21fdb44 AS ubuntu-24.10

FROM ${base_image}

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gnome-session \
        gjs \
        dbus-user-session \
        gdm3 \
        gir1.2-vte-2.91 \
        gir1.2-vte-3.91 \
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
