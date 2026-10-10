FROM quay.io/fedora/fedora:45

# renovate: datasource=custom.bodhi depName=gnome-shell packageName=gnome-shell&status=stable&releases=F45 extractVersion=^gnome-shell-(?<version>\d.*)$
ARG GNOME_SHELL_VERSION=51.0-1.fc45

# renovate: datasource=custom.bodhi depName=mutter packageName=mutter&status=stable&releases=F45 extractVersion=^mutter-(?<version>\d.*)$
ARG MUTTER_VERSION=51.0-1.fc45

# renovate: datasource=custom.bodhi depName=gjs packageName=gjs&status=stable&releases=F45 extractVersion=^gjs-(?<version>\d.*)$
ARG GJS_VERSION=1.90.0-1.fc45

# renovate: datasource=custom.bodhi depName=vte packageName=vte291&status=stable&releases=F45 extractVersion=^vte291-(?<version>\d.*)$
ARG VTE_VERSION=0.84.1-1.fc45

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
