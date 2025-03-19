FROM docker.io/library/ubuntu:24.10

# renovate: datasource=repology depName=ubuntu_24_10/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=47.0-2ubuntu3

COPY scripts/install-debian.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
