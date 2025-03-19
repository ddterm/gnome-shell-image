FROM docker.io/library/debian:12

# renovate: datasource=repology depName=debian_12/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=43.9-0+deb12u2

COPY scripts/install-debian.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
