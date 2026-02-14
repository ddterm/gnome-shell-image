FROM quay.io/fedora/fedora:43

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='fedora_43']
ARG GNOME_SHELL_VERSION=49.4-1.fc43

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='fedora_43']
ARG MUTTER_VERSION=49.4-1.fc43

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='fedora_43']
ARG GJS_VERSION=1.86.0-1.fc43

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='fedora_43']
ARG VTE_VERSION=0.82.3-1.fc43

COPY scripts/install-fedora.sh /usr/local/bin/
RUN env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_VERSION=$GJS_VERSION" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
