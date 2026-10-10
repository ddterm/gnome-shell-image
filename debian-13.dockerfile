FROM docker.io/library/debian:trixie

RUN --mount=type=bind,source=scripts/install-debian.sh,target=/usr/local/bin/install-debian.sh \
    /usr/local/bin/install-debian.sh

COPY data /

RUN --mount=type=bind,source=scripts/configure-systemd.sh,target=/usr/local/bin/configure-systemd.sh \
    /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
