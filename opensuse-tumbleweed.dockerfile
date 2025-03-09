FROM docker.io/opensuse/tumbleweed:latest@sha256:d74a6e0886a8f2c1c6a761010f5ec23977c6ccd8fe1a9a3d267c44ea3b65887d

# renovate: datasource=repology depName=opensuse_tumbleweed/gnome-shell versioning=rpm
ARG GNOME_SHELL_VERSION=47.5-1.1

COPY scripts/install-suse.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
