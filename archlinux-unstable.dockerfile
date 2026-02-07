FROM ghcr.io/archlinux/archlinux:base

RUN sed -i -E 's/^#(\[.*-testing\])$/\1/g' /etc/pacman.conf && \
    sed -i -E 's/^#(Include = .*)$/\1/g' /etc/pacman.conf && \
    echo -e "[gnome-unstable]\nInclude = /etc/pacman.d/mirrorlist" >/etc/pacman.conf.new && \
    cat /etc/pacman.conf >>/etc/pacman.conf.new && \
    mv -f /etc/pacman.conf.new /etc/pacman.conf

COPY scripts/install-archlinux.sh /usr/local/bin/
RUN /usr/local/bin/install-archlinux.sh

COPY data /

COPY scripts/configure-systemd.sh /usr/local/bin/
RUN /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
