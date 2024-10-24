ARG base_image=opensuse-tumbleweed

FROM docker.io/opensuse/tumbleweed:latest@sha256:bb2d697f63b1c833047a1335cd1e55716f3d3d1f5048ff55b4aa837690723476 AS opensuse-tumbleweed
FROM docker.io/opensuse/leap:15.6@sha256:8cf656d677c02d31db333fcc2f97c7fcaa1ced47437f3b6e2582bd4ddce058ed AS opensuse-leap-15.6

FROM ${base_image}

RUN zypper --non-interactive install --no-recommends \
        systemd-sysvinit \
        xorg-x11-server-Xvfb \
        gjs \
        gdm \
        gnome-session-wayland \
        gnome-extensions \
        gtk3-metatheme-adwaita \
        typelib-1_0-Vte-2.91 \
        typelib-1_0-Vte-3_91 \
        PackageKit \
        typelib-1_0-PackageKitGlib-1_0 \
        typelib-1_0-Handy-1_0 \
        wl-clipboard \
    && zypper clean --all

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

CMD [ "/sbin/init" ]
