FROM docker.io/library/alpine:3.18

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='alpine_3_18']
ARG GNOME_SHELL_VERSION=44.8-r0

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='alpine_3_18']
ARG MUTTER_VERSION=44.8-r0

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='alpine_3_18']
ARG GJS_VERSION=1.76.2-r0

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='alpine_3_18']
ARG VTE_VERSION=0.72.2-r0

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
