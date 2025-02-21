FROM docker.io/library/archlinux:latest@sha256:3a7ff222088d954173df233a61ced6a8201f13f60941c22d6e1fb69f0ed517b9

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
