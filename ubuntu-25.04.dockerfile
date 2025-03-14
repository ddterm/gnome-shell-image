FROM docker.io/library/ubuntu:25.04@sha256:008b026f11c0b5653d564d0c9877a116770f06dfbdb36ca75c46fd593d863cbc

# renovate: datasource=repology depName=ubuntu_25_04_proposed/gnome-shell versioning=deb
ARG GNOME_SHELL_VERSION=48~rc-2ubuntu3

# Enable -proposed temporarily
RUN sed -i '/^Suites:.*plucky-updates/ s/$/ plucky-proposed/' /etc/apt/sources.list.d/ubuntu.sources && \
    echo 'Package: *gnome-shell* *mutter*' >/etc/apt/preferences.d/gnome-shell-proposed && \
    echo 'Pin: release a=plucky-proposed' >>/etc/apt/preferences.d/gnome-shell-proposed && \
    echo 'Pin-Priority: 500' >>/etc/apt/preferences.d/gnome-shell-proposed

COPY scripts/install-debian.sh /usr/local/bin/
RUN env "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
