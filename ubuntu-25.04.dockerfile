FROM docker.io/library/ubuntu:25.04

# renovate: datasource=repology depName=ubuntu_25_04/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=48~rc-2ubuntu3

# renovate: datasource=repology depName=ubuntu_25_04/mutter versioning=deb
ARG MUTTER_VERSION=48~rc-4ubuntu2

COPY scripts/install-debian.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
