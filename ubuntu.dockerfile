ARG base_image=ubuntu-24.04

FROM docker.io/library/ubuntu:22.04@sha256:ed1544e454989078f5dec1bfdabd8c5cc9c48e0705d07b678ab6ae3fb61952d2 AS ubuntu-22.04
FROM docker.io/library/ubuntu:24.04@sha256:72297848456d5d37d1262630108ab308d3e9ec7ed1c3286a32fe09856619a782 AS ubuntu-24.04
FROM docker.io/library/ubuntu:24.10@sha256:102bc1874fdb136fc2d218473f03cf84135cb7496fefdb9c026c0f553cfe1b6d AS ubuntu-24.10

FROM ${base_image}
ARG base_image

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ubuntu-desktop-minimal \
        dbus-user-session \
        gir1.2-vte-2.91 \
        $(if [ $base_image != ubuntu-22.04 ]; then echo gir1.2-vte-3.91; fi) \
        xvfb \
        wl-clipboard \
        gir1.2-handy-1

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

ENV GNOME_SHELL_SESSION_MODE=ubuntu
ENV XDG_CURRENT_DESKTOP=ubuntu:GNOME

CMD [ "/sbin/init" ]
