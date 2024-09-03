FROM docker.io/library/archlinux:latest@sha256:649f22ffe44950a2fbdd7b4f3ad7eaf1ae017d60360f857ba1b07902121824d4

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
    useradd -m -U -G users,adm gnomeshell && \
    truncate --size 0 /etc/machine-id && \
    dconf update

CMD [ "/sbin/init" ]
