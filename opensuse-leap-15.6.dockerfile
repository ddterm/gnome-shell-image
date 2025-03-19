FROM docker.io/opensuse/leap:15.6

# renovate: datasource=repology depName=opensuse_leap_15_6/gnome-shell versioning=rpm
ARG GNOME_SHELL_VERSION=45.3-150600.5.9.2

COPY scripts/install-suse.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
