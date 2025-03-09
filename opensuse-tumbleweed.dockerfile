FROM docker.io/opensuse/tumbleweed:latest@sha256:7246f984fdfa5b7408931c0758b31dc8b003f8731e76a698ce61bfe8c7623ea2

COPY scripts/install-suse.sh /usr/local/bin/
RUN /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
