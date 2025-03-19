FROM docker.io/library/ubuntu:24.10

# renovate: datasource=repology depName=ubuntu_24_10/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=47.0-2ubuntu3

# renovate: datasource=repology depName=ubuntu_24_10/mutter versioning=deb
ARG MUTTER_VERSION=47.0-1ubuntu4.3

# renovate: datasource=repology depName=ubuntu_24_10/gjs versioning=deb
ARG GJS_VERSION=1.82.0-1

COPY scripts/install-debian.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
