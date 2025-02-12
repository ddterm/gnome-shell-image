FROM docker.io/library/archlinux:latest@sha256:e45ad60acc53d4b59ef4ef287721cf7a03e09525eeb407d15acef975b847ab30

RUN pacman -Rdd --noconfirm dbus-broker-units \
    && pacman -Syu --noconfirm \
        dbus-daemon-units \
        gnome-shell \
        vte3 \
        vte4 \
        xorg-server-xvfb \
        xorg-xinit \
        mesa \
        gdm \
        wl-clipboard \
        libhandy \
    && pacman -Scc --noconfirm

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
