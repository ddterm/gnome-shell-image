FROM docker.io/library/ubuntu:25.10

# renovate: datasource=deb depName=gnome-shell
ARG GNOME_SHELL_VERSION=49.0-1ubuntu1.2

# renovate: datasource=deb depName=mutter
ARG MUTTER_VERSION=49.0-2ubuntu5.3

# renovate: datasource=deb depName=gjs
ARG GJS_VERSION=1.86.0-1

# renovate: datasource=deb depName=vte packageName=libvte-2.91-0
ARG VTE_VERSION=0.80.3-3

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
