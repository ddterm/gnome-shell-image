FROM docker.io/library/debian:trixie

# renovate: datasource=repology depName=debian_13/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=48~rc-2

COPY scripts/install-debian.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
