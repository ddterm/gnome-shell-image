FROM docker.io/library/archlinux:latest@sha256:068aa6bfc1e735cdf9be3dbf66327011f99126656f479168f479d68b28181106

# renovate: datasource=repology depName=arch/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=1:47.5-1

COPY scripts/install-archlinux.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-archlinux.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
