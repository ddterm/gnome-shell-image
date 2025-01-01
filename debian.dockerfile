ARG base_image=debian-12

FROM docker.io/library/debian:12@sha256:b877a1a3fdf02469440f1768cf69c9771338a875b7add5e80c45b756c92ac20a AS debian-12
FROM docker.io/library/debian:trixie@sha256:64ed8475618aa290b777fcc3f5d6231f4b7669dcf484229b4c387f31d8456d74 AS debian-13

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
