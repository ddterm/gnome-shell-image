ARG base_image=fedora-40

FROM docker.io/library/fedora:40@sha256:7cdd2b48396929bb8723ea2fa60e03bee39cc22e2a853cbd891587fab4eb1bc9 AS fedora-40
FROM docker.io/library/fedora:41@sha256:3ec60eb34fa1a095c0c34dd37cead9fd38afb62612d43892fcf1d3425c32bc1e AS fedora-41
FROM quay.io/centos/centos:stream9@sha256:680463364408e176d4722de9e8a3ae95b31b5041d47e31399156118cc0627d8f AS centos-stream9

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
        libhandy \
    && dnf clean all -y

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    chmod u+rw /etc/shadow && \
    truncate --size 0 /etc/machine-id

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
