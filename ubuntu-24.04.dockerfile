FROM docker.io/library/ubuntu:24.04

# renovate: datasource=deb depName=gnome-shell
ARG GNOME_SHELL_VERSION=46.0-0ubuntu6~24.04.15

# renovate: datasource=deb depName=mutter
ARG MUTTER_VERSION=46.2-1ubuntu0.24.04.18

# renovate: datasource=deb depName=gjs
ARG GJS_VERSION=1.80.2-1build2

# renovate: datasource=deb depName=vte packageName=libvte-2.91-0
ARG VTE_VERSION=0.76.0-1ubuntu0.1

RUN --mount=type=bind,source=scripts/install-debian.sh,target=/usr/local/bin/install-debian.sh env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

RUN --mount=type=bind,source=scripts/configure-systemd.sh,target=/usr/local/bin/configure-systemd.sh \
    /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
