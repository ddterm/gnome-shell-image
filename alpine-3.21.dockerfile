FROM docker.io/library/alpine:3.21

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='alpine_3_21']
ARG GNOME_SHELL_VERSION=47.6-r0

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='alpine_3_21']
ARG MUTTER_VERSION=47.7-r0

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='alpine_3_21']
ARG GJS_VERSION=1.82.1-r0

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='alpine_3_21']
ARG VTE_VERSION=0.78.4-r0

COPY scripts/install-alpine.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-alpine.sh

COPY scripts/configure-openrc.sh /usr/local/bin/
RUN /usr/local/bin/configure-openrc.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
