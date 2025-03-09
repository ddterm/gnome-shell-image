ARG base_image=debian-12

FROM docker.io/library/debian:12@sha256:35286826a88dc879b4f438b645ba574a55a14187b483d09213a024dc0c0a64ed AS debian-12
FROM docker.io/library/debian:trixie@sha256:2ad7bf4cde8aafcdd2711d03cdd55faaaa0d0f833510ef1c731f885e8ef5b445 AS debian-13

FROM ${base_image}

COPY scripts/install-debian.sh /usr/local/bin/
RUN /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
