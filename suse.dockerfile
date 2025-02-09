ARG base_image=opensuse-tumbleweed

FROM docker.io/opensuse/tumbleweed:latest@sha256:62fce14fc3305064dacaec880c8111698fe129afbea8202789274756bdee8d88 AS opensuse-tumbleweed
FROM docker.io/opensuse/leap:15.6@sha256:3169ee9dabf16aa72d0947901d53478f8936da817ab2fc240ee37c6bd5f7deb2 AS opensuse-leap-15.6

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
