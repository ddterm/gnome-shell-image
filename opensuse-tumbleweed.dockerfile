FROM docker.io/opensuse/tumbleweed:latest

# renovate: datasource=repology depName=opensuse_tumbleweed/gnome-shell versioning=rpm
ARG GNOME_SHELL_VERSION=48.0-1.1

# renovate: datasource=repology depName=opensuse_tumbleweed/mutter versioning=rpm
ARG MUTTER_VERSION=48.0-1.1

# renovate: datasource=repology depName=opensuse_tumbleweed/gjs versioning=rpm
ARG GJS_VERSION=1.82.1-1.4

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
