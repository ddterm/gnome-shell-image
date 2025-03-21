FROM docker.io/library/alpine:3.20

# renovate: datasource=custom.repology.alpine_3_20 depName=gnome-shell
ARG GNOME_SHELL_VERSION=46.1-r0

# renovate: datasource=custom.repology.alpine_3_20 depName=mutter
ARG MUTTER_VERSION=46.1-r0

# renovate: datasource=custom.repology.alpine_3_20 depName=gjs
ARG GJS_VERSION=1.80.2-r1

COPY scripts/install-alpine.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-alpine.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
