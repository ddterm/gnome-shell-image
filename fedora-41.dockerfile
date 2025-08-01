FROM quay.io/fedora/fedora:41

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='fedora_41']
ARG GNOME_SHELL_VERSION=47.8-1.fc41

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='fedora_41']
ARG MUTTER_VERSION=47.9-1.fc41

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='fedora_41']
ARG GJS_VERSION=1.82.3-1.fc41

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='fedora_41']
ARG VTE_VERSION=0.78.4-1.fc41

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
