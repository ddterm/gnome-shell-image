FROM docker.io/opensuse/tumbleweed:latest

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='opensuse_tumbleweed']
ARG GNOME_SHELL_VERSION=48.0-2.1

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='opensuse_tumbleweed']
ARG MUTTER_VERSION=48.0+5-1.1

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='opensuse_tumbleweed']
ARG GJS_VERSION=1.84.1-1.1

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='opensuse_tumbleweed']
ARG VTE_VERSION=0.80.0-1.1

COPY scripts/install-suse.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
