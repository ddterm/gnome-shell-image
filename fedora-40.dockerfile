FROM docker.io/library/fedora:40@sha256:7cdd2b48396929bb8723ea2fa60e03bee39cc22e2a853cbd891587fab4eb1bc9

COPY scripts/install-fedora.sh /usr/local/bin/
RUN /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
