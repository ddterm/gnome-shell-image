FROM docker.io/library/debian:12@sha256:35286826a88dc879b4f438b645ba574a55a14187b483d09213a024dc0c0a64ed

# renovate: datasource=repology depName=debian_12/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=43.9-0+deb12u2

COPY scripts/install-debian.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
