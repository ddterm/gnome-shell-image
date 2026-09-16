FROM quay.io/fedora/fedora:44

# renovate: datasource=custom.bodhi depName=gnome-shell packageName=gnome-shell&status=stable&releases=F44 extractVersion=^gnome-shell-(?<version>\d.*)$
ARG GNOME_SHELL_VERSION=50.4-1.fc44

# renovate: datasource=custom.bodhi depName=mutter packageName=mutter&status=stable&releases=F44 extractVersion=^mutter-(?<version>\d.*)$
ARG MUTTER_VERSION=50.4-1.fc44

# renovate: datasource=custom.bodhi depName=gjs packageName=gjs&status=stable&releases=F44 extractVersion=^gjs-(?<version>\d.*)$
ARG GJS_VERSION=1.88.1-2.fc44

# renovate: datasource=custom.bodhi depName=vte packageName=vte291&status=stable&releases=F44 extractVersion=^vte291-(?<version>\d.*)$
ARG VTE_VERSION=0.84.1-1.fc44

COPY scripts/install-fedora.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
