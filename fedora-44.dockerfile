FROM quay.io/fedora/fedora:44

# renovate: datasource=custom.repology depName=gnome-shell packageName=gnome-shell[repo='fedora_44']
ARG GNOME_SHELL_VERSION=50.3-1.fc44

# renovate: datasource=custom.repology depName=mutter packageName=mutter[repo='fedora_44']
ARG MUTTER_VERSION=50.1-1.fc44

# renovate: datasource=custom.repology depName=gjs packageName=gjs[repo='fedora_44']
ARG GJS_VERSION=1.88.1-1.fc44

# renovate: datasource=custom.repology depName=vte packageName=vte[repo='fedora_44']
ARG VTE_VERSION=0.84.0-1.fc44

COPY scripts/install-fedora.sh /usr/local/bin/
RUN /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
