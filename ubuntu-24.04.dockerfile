FROM docker.io/library/ubuntu:24.04

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='ubuntu_24_04']
ARG GNOME_SHELL_VERSION=46.0-0ubuntu6~24.04.6

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='ubuntu_24_04']
ARG MUTTER_VERSION=46.2-1ubuntu0.24.04.6

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='ubuntu_24_04']
ARG GJS_VERSION=1.80.2-1build2

COPY scripts/install-debian.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
