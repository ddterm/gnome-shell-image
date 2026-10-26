FROM docker.io/library/debian:forky

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='debian_14']
ARG GNOME_SHELL_VERSION=50.5-1

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='debian_14']
ARG MUTTER_VERSION=50.5-1

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='debian_14']
ARG GJS_VERSION=1.90.1-1

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='debian_14'][srcname='vte2.91']
ARG VTE_VERSION=0.84.1-1+b1

RUN --mount=type=bind,source=scripts/install-debian.sh,target=/usr/local/bin/install-debian.sh \
    env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-debian.sh

COPY data /

RUN --mount=type=bind,source=scripts/configure-systemd.sh,target=/usr/local/bin/configure-systemd.sh \
    /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
