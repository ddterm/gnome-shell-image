FROM quay.io/fedora/fedora:41

# renovate: datasource=custom.repology.fedora_41 depName=gnome-shell
ARG GNOME_SHELL_VERSION=47.4-1.fc41

# renovate: datasource=custom.repology.fedora_41 depName=mutter
ARG MUTTER_VERSION=47.5-1.fc41

# renovate: datasource=custom.repology.fedora_41 depName=gjs
ARG GJS_VERSION=1.82.1-3.fc41

COPY scripts/install-fedora.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
