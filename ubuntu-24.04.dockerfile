FROM docker.io/library/ubuntu:24.04@sha256:72297848456d5d37d1262630108ab308d3e9ec7ed1c3286a32fe09856619a782

COPY scripts/install-debian.sh /usr/local/bin/
RUN /usr/local/bin/install-debian.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
