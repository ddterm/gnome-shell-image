FROM ghcr.io/archlinux/archlinux:base

# renovate: datasource=custom.archlinux depName=gnome-shell packageName=gnome-shell&repo=Extra
ARG GNOME_SHELL_VERSION=1:50.5-1

# renovate: datasource=custom.archlinux depName=mutter packageName=mutter&repo=Extra
ARG MUTTER_VERSION=50.5-1

# renovate: datasource=custom.archlinux depName=gjs packageName=gjs&repo=Extra
ARG GJS_VERSION=2:1.88.1-1

# renovate: datasource=custom.archlinux depName=vte packageName=vte3&repo=Extra
ARG VTE_VERSION=0.84.1-1

COPY scripts/install-archlinux.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-archlinux.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
