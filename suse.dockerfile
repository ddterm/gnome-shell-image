ARG base_image=opensuse-tumbleweed

FROM docker.io/opensuse/tumbleweed:latest@sha256:82765f87a5c1b96779823f4a3150f4b7a940dea0f0768163b974e3e88940d6e1 AS opensuse-tumbleweed
FROM docker.io/opensuse/leap:15.6@sha256:7a84d2c38490d672c37e4f82e3b18b1fb666905b9924196495e6689b103dcd31 AS opensuse-leap-15.6

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
        typelib-1_0-Handy-1_0 \
        wl-clipboard \
    && zypper clean --all

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
