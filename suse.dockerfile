ARG base_image=opensuse-tumbleweed

FROM docker.io/opensuse/tumbleweed:latest@sha256:a8497fc52af9d8e9a2205de564eafe679d76128d80fb82846571d6aa0dc5cb6a AS opensuse-tumbleweed
FROM docker.io/opensuse/leap:15.6@sha256:d3a517b66067d9f150dbd57d7ad28e0806025ad6f3a3e8c71b09cc7230b833a6 AS opensuse-leap-15.6

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
