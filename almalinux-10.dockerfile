FROM ghcr.io/almalinux/10-init:latest

# renovate: datasource=rpm depName=gnome-shell
ARG GNOME_SHELL_VERSION=49.4-8.el10_2.alma.1

# renovate: datasource=rpm depName=mutter
ARG MUTTER_VERSION=49.4-4.el10_2

# renovate: datasource=rpm depName=gjs
ARG GJS_VERSION=1.80.2-11.el10

# renovate: datasource=rpm depName=vte packageName=vte291
ARG VTE_VERSION=0.78.6-1.el10

COPY scripts/install-fedora.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
