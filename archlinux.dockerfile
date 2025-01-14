FROM docker.io/library/archlinux:latest@sha256:9d946f864864c3792284dbda5819833a861d05120411b1ac25f8640db71d6b81

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
