FROM ghcr.io/almalinux/10-init:latest

# renovate: datasource=rpm depName=gnome-shell
ARG GNOME_SHELL_VERSION=49.4-9.el10_2.alma.1

# renovate: datasource=rpm depName=mutter
ARG MUTTER_VERSION=49.4-4.el10_2

# renovate: datasource=rpm depName=gjs
ARG GJS_VERSION=1.80.2-11.el10

# renovate: datasource=rpm depName=vte packageName=vte291
ARG VTE_VERSION=0.78.6-1.el10

RUN --mount=type=bind,source=scripts/install-fedora.sh,target=/usr/local/bin/install-fedora.sh env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-fedora.sh

COPY data /

RUN --mount=type=bind,source=scripts/configure-systemd.sh,target=/usr/local/bin/configure-systemd.sh \
    /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
