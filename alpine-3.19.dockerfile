FROM docker.io/library/alpine:3.19@sha256:e5d0aea7f7d2954678a9a6269ca2d06e06591881161961ea59e974dff3f12377

# renovate: datasource=repology depName=alpine_3_19/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=45.3-r0

COPY scripts/install-alpine.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-alpine.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
