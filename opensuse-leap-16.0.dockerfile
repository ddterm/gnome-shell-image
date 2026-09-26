FROM docker.io/opensuse/leap:16.0

# renovate: datasource=rpm depName=gnome-shell
ARG GNOME_SHELL_VERSION=48.4-160000.2.1

# renovate: datasource=rpm depName=mutter
ARG MUTTER_VERSION=48.4-160000.2.2

# renovate: datasource=rpm depName=gjs
ARG GJS_VERSION=1.84.2-160000.2.2

# renovate: datasource=rpm depName=vte packageName=typelib-1_0-Vte-2_91
ARG VTE_VERSION=0.80.3-160000.2.2

RUN --mount=type=bind,source=scripts/install-suse.sh,target=/usr/local/bin/install-suse.sh env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-suse.sh

COPY data /

RUN --mount=type=bind,source=scripts/configure-systemd.sh,target=/usr/local/bin/configure-systemd.sh \
    /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
