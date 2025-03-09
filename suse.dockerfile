ARG base_image=opensuse-tumbleweed

FROM docker.io/opensuse/tumbleweed:latest@sha256:7246f984fdfa5b7408931c0758b31dc8b003f8731e76a698ce61bfe8c7623ea2 AS opensuse-tumbleweed
FROM docker.io/opensuse/leap:15.6@sha256:7a84d2c38490d672c37e4f82e3b18b1fb666905b9924196495e6689b103dcd31 AS opensuse-leap-15.6

FROM ${base_image}

COPY scripts/install-suse.sh /usr/local/bin/
RUN /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
