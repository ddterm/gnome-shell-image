FROM docker.io/opensuse/tumbleweed:latest

# renovate: datasource=custom.opensuse-downloads depName=gnome-shell packageName=tumbleweed/repo/oss/x86_64 versioning=rpm extractVersion=^gnome-shell-(?<version>\d.*)\.x86_64\.rpm
ARG GNOME_SHELL_VERSION=50.5-1.1

# renovate: datasource=custom.opensuse-downloads depName=mutter packageName=tumbleweed/repo/oss/x86_64 versioning=rpm extractVersion=^mutter-(?<version>\d.*)\.x86_64\.rpm
ARG MUTTER_VERSION=50.5-1.1

# renovate: datasource=custom.opensuse-downloads depName=gjs packageName=tumbleweed/repo/oss/x86_64 versioning=rpm extractVersion=^gjs-(?<version>\d.*)\.x86_64\.rpm
ARG GJS_VERSION=1.88.1-2.1

# renovate: datasource=custom.opensuse-downloads depName=vte packageName=tumbleweed/repo/oss/x86_64 versioning=rpm extractVersion=^typelib-1_0-Vte-2_91-(?<version>\d.*)\.x86_64\.rpm
ARG VTE_VERSION=0.84.1-1.3

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
