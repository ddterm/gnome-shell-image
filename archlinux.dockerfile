FROM ghcr.io/archlinux/archlinux:base

# renovate: datasource=repology depName=arch/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=1:47.5-1

# renovate: datasource=repology depName=arch/mutter versioning=deb
ARG MUTTER_VERSION=47.6-1

# renovate: datasource=repology depName=arch/gjs versioning=deb
ARG GJS_VERSION=2:1.82.1-2

COPY scripts/install-archlinux.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-archlinux.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
