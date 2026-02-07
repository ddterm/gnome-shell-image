FROM quay.io/fedora/fedora:44

COPY scripts/install-fedora.sh /usr/local/bin/
RUN /usr/local/bin/install-fedora.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
