FROM docker.io/library/alpine:3.20@sha256:de4fe7064d8f98419ea6b49190df1abbf43450c1702eeb864fe9ced453c1cc5f

# renovate: datasource=repology depName=alpine_3_20/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=46.1-r0

COPY scripts/install-alpine.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-alpine.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
