FROM docker.io/opensuse/tumbleweed:latest@sha256:6fb156c7151f3fdffc651421e2d32029d0faad7a2550c4a07ea27685bcdfd271

# renovate: datasource=repology depName=opensuse_tumbleweed/gnome-shell versioning=rpm
ARG GNOME_SHELL_VERSION=47.5-1.2

COPY scripts/install-suse.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
