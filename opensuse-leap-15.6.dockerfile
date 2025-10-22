FROM docker.io/opensuse/leap:15.6

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='opensuse_leap_15_6']
ARG GNOME_SHELL_VERSION=45.3-150600.5.9.2

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='opensuse_leap_15_6']
ARG MUTTER_VERSION=45.3-150600.5.20.2

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='opensuse_leap_15_6']
ARG GJS_VERSION=1.78.1-150600.1.3

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='opensuse_leap_15_6']
ARG VTE_VERSION=0.74.2-150600.3.3.1

COPY scripts/install-suse.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
