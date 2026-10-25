FROM quay.io/fedora/fedora:44

# renovate: datasource=rpm depName=gnome-shell packageName=gnome-shell
ARG GNOME_SHELL_VERSION=50.6-1.fc44

# renovate: datasource=rpm depName=mutter packageName=mutter
ARG MUTTER_VERSION=50.6-1.fc44

# renovate: datasource=rpm depName=gjs packageName=gjs
ARG GJS_VERSION=1.88.1-2.fc44

# renovate: datasource=rpm depName=vte packageName=vte291
ARG VTE_VERSION=0.84.1-1.fc44

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
