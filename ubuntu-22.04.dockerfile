FROM docker.io/library/ubuntu:22.04

# renovate: datasource=deb depName=gnome-shell
ARG GNOME_SHELL_VERSION=42.9-0ubuntu2.2

# renovate: datasource=deb depName=mutter
ARG MUTTER_VERSION=42.9-0ubuntu9

# renovate: datasource=deb depName=gjs
ARG GJS_VERSION=1.72.4-0ubuntu0.22.04.4

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
