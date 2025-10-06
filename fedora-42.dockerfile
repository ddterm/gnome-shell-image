FROM quay.io/fedora/fedora:42

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='fedora_42']
ARG GNOME_SHELL_VERSION=48.5-1.fc42

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='fedora_42']
ARG MUTTER_VERSION=48.5-1.fc42

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='fedora_42']
ARG GJS_VERSION=1.84.2-2.fc42

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='fedora_42']
ARG VTE_VERSION=0.80.4-1.fc42

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
