FROM docker.io/library/archlinux:latest@sha256:89639d3a2d102158ab5a6668dc340a6e5cf1acf12f78b55b508b8c38da461869

RUN pacman -Rdd --noconfirm dbus-broker-units \
    && pacman -Syu --noconfirm \
        dbus-daemon-units \
        gnome-shell \
        vte3 \
        vte4 \
        xorg-server-xvfb \
        xorg-xinit \
        mesa \
        packagekit \
        gdm \
        wl-clipboard \
        libhandy \
    && pacman -Scc --noconfirm

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

CMD [ "/sbin/init" ]
