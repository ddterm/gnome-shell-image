ARG base_image=ubuntu-24.04

FROM docker.io/library/ubuntu:22.04@sha256:0e5e4a57c2499249aafc3b40fcd541e9a456aab7296681a3994d631587203f97 AS ubuntu-22.04
FROM docker.io/library/ubuntu:24.04@sha256:80dd3c3b9c6cecb9f1667e9290b3bc61b78c2678c02cbdae5f0fea92cc6734ab AS ubuntu-24.04
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
