FROM docker.io/library/debian:trixie@sha256:2ad7bf4cde8aafcdd2711d03cdd55faaaa0d0f833510ef1c731f885e8ef5b445

COPY scripts/install-debian.sh /usr/local/bin/
RUN /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
