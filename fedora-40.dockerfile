FROM quay.io/fedora/fedora:40

# renovate: datasource=custom.repology.fedora_40 depName=gnome-shell
ARG GNOME_SHELL_VERSION=46.9-1.fc40

# renovate: datasource=custom.repology.fedora_40 depName=mutter
ARG MUTTER_VERSION=46.8-2.fc40

# renovate: datasource=custom.repology.fedora_40 depName=gjs
ARG GJS_VERSION=1.80.2-3.fc40

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
