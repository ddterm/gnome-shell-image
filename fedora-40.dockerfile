FROM quay.io/fedora/fedora:40

# renovate: datasource=repology depName=fedora_40/gnome-shell versioning=rpm
ARG GNOME_SHELL_VERSION=46.9-1.fc40

COPY scripts/install-fedora.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
