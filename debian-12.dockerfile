FROM docker.io/library/debian:12

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='debian_12']
ARG GNOME_SHELL_VERSION=43.9-0+deb12u2

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='debian_12']
ARG MUTTER_VERSION=43.8-0+deb12u1

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='debian_12']
ARG GJS_VERSION=1.74.2-1+deb12u1

COPY scripts/install-debian.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
