FROM quay.io/centos/centos:10

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='centos_stream_10']
ARG GNOME_SHELL_VERSION=47.10-1.el10

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='centos_stream_10']
ARG MUTTER_VERSION=47.5-13.el10

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='centos_stream_10']
ARG GJS_VERSION=1.80.2-11.el10

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='centos_stream_10']
ARG VTE_VERSION=0.78.4-1.el10

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
