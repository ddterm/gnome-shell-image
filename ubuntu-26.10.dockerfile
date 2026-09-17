FROM docker.io/library/ubuntu:26.10

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='ubuntu_26_10']
ARG GNOME_SHELL_VERSION=51.0-2ubuntu3

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='ubuntu_26_10']
ARG MUTTER_VERSION=51.0-1ubuntu3

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='ubuntu_26_10']
ARG GJS_VERSION=1.90.0-1

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='ubuntu_26_10'][srcname='vte2.91']
ARG VTE_VERSION=0.84.1-1

COPY scripts/install-debian.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
