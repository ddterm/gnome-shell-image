FROM docker.io/library/ubuntu:22.04@sha256:ed1544e454989078f5dec1bfdabd8c5cc9c48e0705d07b678ab6ae3fb61952d2

COPY scripts/install-debian.sh /usr/local/bin/
RUN /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
