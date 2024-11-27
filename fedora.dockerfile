ARG base_image=fedora-40

FROM docker.io/library/fedora:39@sha256:d63d63fe593749a5e8dbc8152427d40bbe0ece53d884e00e5f3b44859efa5077 AS fedora-39
FROM docker.io/library/fedora:40@sha256:7cdd2b48396929bb8723ea2fa60e03bee39cc22e2a853cbd891587fab4eb1bc9 AS fedora-40
FROM docker.io/library/fedora:41@sha256:3ec60eb34fa1a095c0c34dd37cead9fd38afb62612d43892fcf1d3425c32bc1e AS fedora-41
FROM quay.io/centos/centos:stream9@sha256:fc94f4a0545cac9d6ea76e087b1482ea12b7166a35ffde69eb9708d2e17af148 AS centos-stream9

FROM ${base_image}
ARG base_image

RUN if [ $base_image = centos-stream9 ]; then dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm; fi && \
    dnf install -y --nodocs --setopt install_weak_deps=False \
        gnome-session-xsession \
        gnome-extensions-app \
        gjs \
        gdm \
        vte291 \
        $(if [ $base_image != centos-stream9 ]; then echo vte291-gtk4; fi) \
        xorg-x11-server-Xvfb \
        mesa-dri-drivers \
        wl-clipboard \
        PackageKit \
        PackageKit-glib \
        libhandy \
    && dnf clean all -y

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    chmod u+rw /etc/shadow && \
    truncate --size 0 /etc/machine-id

CMD [ "/sbin/init" ]
