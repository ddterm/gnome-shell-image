ARG base_image=ubuntu-24.04

FROM docker.io/library/debian:12@sha256:b8084b1a576c5504a031936e1132574f4ce1d6cc7130bbcc25a28f074539ae6b AS debian-12
FROM docker.io/library/debian:trixie@sha256:9f7b513ffd1a78901e6802e47ac03c3e8b5d5bafb06054ed8c757f9a043c2e60 AS debian-13
FROM docker.io/library/ubuntu:22.04@sha256:58b87898e82351c6cf9cf5b9f3c20257bb9e2dcf33af051e12ce532d7f94e3fe AS ubuntu-22.04
FROM docker.io/library/ubuntu:24.04@sha256:dfc10878be8d8fc9c61cbff33166cb1d1fe44391539243703c72766894fa834a AS ubuntu-24.04

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
