FROM docker.io/opensuse/tumbleweed:latest@sha256:0dd6a41f9e87f6664c5420e3d95847e46826469733ee64c50f979a026b29fb52

# renovate: datasource=repology depName=opensuse_tumbleweed/gnome-shell versioning=rpm
ARG GNOME_SHELL_VERSION=47.5-1.2

COPY scripts/install-suse.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
