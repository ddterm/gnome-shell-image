FROM ghcr.io/archlinux/archlinux:base

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='arch']
ARG GNOME_SHELL_VERSION=1:48.3-1

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='arch']
ARG MUTTER_VERSION=48.4-1

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='arch']
ARG GJS_VERSION=2:1.84.2-1

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='arch']
ARG VTE_VERSION=0.80.3-1

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
