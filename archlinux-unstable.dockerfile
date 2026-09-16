FROM ghcr.io/archlinux/archlinux:base

# renovate: datasource=custom.archlinux depName=gnome-shell packageName=gnome-shell
ARG GNOME_SHELL_VERSION=1:51.0-1

# renovate: datasource=custom.archlinux depName=mutter packageName=mutter
ARG MUTTER_VERSION=51.0-1

# renovate: datasource=custom.archlinux depName=gjs packageName=gjs
ARG GJS_VERSION=2:1.90.0-1

# renovate: datasource=custom.archlinux depName=vte packageName=vte3
ARG VTE_VERSION=0.84.1-1

RUN sed -i -E 's/^#(\[.*-testing\])$/\1/g' /etc/pacman.conf && \
    sed -i -E 's/^#(Include = .*)$/\1/g' /etc/pacman.conf && \
    echo -e "[gnome-unstable]\nInclude = /etc/pacman.d/mirrorlist" >/etc/pacman.conf.new && \
    cat /etc/pacman.conf >>/etc/pacman.conf.new && \
    mv -f /etc/pacman.conf.new /etc/pacman.conf

COPY scripts/install-archlinux.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-archlinux.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
