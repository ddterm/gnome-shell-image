FROM docker.io/library/alpine:3.20

# renovate: datasource=repology depName=alpine_3_20/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=46.1-r0

# renovate: datasource=repology depName=alpine_3_20/mutter versioning=deb
ARG MUTTER_VERSION=46.1-r0

# renovate: datasource=repology depName=alpine_3_20/gjs versioning=deb
ARG GJS_VERSION=1.80.2-r1

COPY scripts/install-alpine.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-alpine.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
