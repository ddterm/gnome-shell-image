FROM docker.io/library/alpine:3.21

# renovate: datasource=repology depName=alpine_3_21/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=47.5-r0

COPY scripts/install-alpine.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-alpine.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
