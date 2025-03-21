FROM docker.io/library/debian:trixie

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='debian_13']
ARG GNOME_SHELL_VERSION=48~rc-2

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='debian_13']
ARG MUTTER_VERSION=48~rc-4

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='debian_13']
ARG GJS_VERSION=1.82.1-1

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='debian_13'][srcname='vte2.91']
ARG VTE_VERSION=0.79.91-2

COPY scripts/install-debian.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
