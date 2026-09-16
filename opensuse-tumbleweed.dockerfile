FROM docker.io/opensuse/tumbleweed:latest

COPY scripts/install-suse.sh /usr/local/bin/
RUN /usr/local/bin/install-suse.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
