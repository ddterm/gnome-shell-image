FROM docker.io/library/ubuntu:24.10@sha256:102bc1874fdb136fc2d218473f03cf84135cb7496fefdb9c026c0f553cfe1b6d

COPY scripts/install-debian.sh /usr/local/bin/
RUN /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
