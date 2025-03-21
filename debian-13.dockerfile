FROM docker.io/library/debian:trixie

# renovate: datasource=custom.repology.debian_13 depName=gnome-shell
ARG GNOME_SHELL_VERSION=48~rc-2

# renovate: datasource=custom.repology.debian_13 depName=mutter
ARG MUTTER_VERSION=48~rc-4

# renovate: datasource=custom.repology.debian_13 depName=gjs
ARG GJS_VERSION=1.82.1-1

COPY scripts/install-debian.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
