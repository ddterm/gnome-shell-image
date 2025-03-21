FROM docker.io/opensuse/leap:15.6

# renovate: datasource=custom.repology.opensuse_leap_15_6 depName=gnome-shell
ARG GNOME_SHELL_VERSION=45.3-150600.5.9.2

# renovate: datasource=custom.repology.opensuse_leap_15_6 depName=mutter
ARG MUTTER_VERSION=45.3-150600.5.9.1

# renovate: datasource=custom.repology.opensuse_leap_15_6 depName=gjs
ARG GJS_VERSION=1.78.1-150600.1.3

COPY scripts/install-suse.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
