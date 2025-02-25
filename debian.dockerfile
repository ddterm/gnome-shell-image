ARG base_image=debian-12

FROM docker.io/library/debian:12@sha256:35286826a88dc879b4f438b645ba574a55a14187b483d09213a024dc0c0a64ed AS debian-12
FROM docker.io/library/debian:trixie@sha256:2ad7bf4cde8aafcdd2711d03cdd55faaaa0d0f833510ef1c731f885e8ef5b445 AS debian-13

FROM ${base_image}
ARG base_image

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gnome-session \
        gjs \
        dbus-user-session \
        gdm3 \
        gir1.2-vte-2.91 \
        gir1.2-vte-3.91 \
        xvfb \
        wl-clipboard \
        gir1.2-handy-1

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
