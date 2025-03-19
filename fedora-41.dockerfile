FROM quay.io/fedora/fedora:41

# renovate: datasource=repology depName=fedora_41/gnome-shell versioning=rpm
ARG GNOME_SHELL_VERSION=47.4-1.fc41

# renovate: datasource=repology depName=fedora_41/mutter versioning=rpm
ARG MUTTER_VERSION=47.5-1.fc41

COPY scripts/install-fedora.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
