ARG base_image=opensuse-tumbleweed

FROM docker.io/opensuse/tumbleweed:latest@sha256:3e212f090fac6740340f658cc3a4076a3e2ecc660f87bedd055d563a40c88be3 AS opensuse-tumbleweed
FROM docker.io/opensuse/leap:15.6@sha256:8cf656d677c02d31db333fcc2f97c7fcaa1ced47437f3b6e2582bd4ddce058ed AS opensuse-leap-15.6

FROM ${base_image}
ARG base_image

RUN mkdir -p /usr/share/xsessions && \
    touch /usr/share/xsessions/gnome.desktop && \
    zypper --non-interactive install --no-recommends \
        systemd-sysvinit \
        xorg-x11-server-Xvfb \
        $(if [ $base_image = opensuse-tumbleweed ]; then echo gnome-session-xsession; fi) \
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
