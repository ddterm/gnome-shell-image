ARG base_image=ubuntu-24.04

FROM docker.io/library/debian:12@sha256:10901ccd8d249047f9761845b4594f121edef079cfd8224edebd9ea726f0a7f6 AS debian-12
FROM docker.io/library/debian:trixie@sha256:6f307cf9f47c64b238872829d8d84e8cf1717c97d47b153114fd3c8c47336a52 AS debian-13
FROM docker.io/library/ubuntu:22.04@sha256:0e5e4a57c2499249aafc3b40fcd541e9a456aab7296681a3994d631587203f97 AS ubuntu-22.04
FROM docker.io/library/ubuntu:24.04@sha256:278628f08d4979fb9af9ead44277dbc9c92c2465922310916ad0c46ec9999295 AS ubuntu-24.04
FROM docker.io/library/ubuntu:24.10@sha256:eea047b4b181f2d3aeafbc0ce5294a2bbb3b98153a68b9ed4bc573d871ca9450 AS ubuntu-24.10

FROM ${base_image}
ARG base_image

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gnome-session \
        gjs \
        dbus-user-session \
        gdm3 \
        gir1.2-vte-2.91 \
        $(if [ $base_image != ubuntu-22.04 ]; then echo gir1.2-vte-3.91; fi) \
        xvfb \
        packagekit \
        gir1.2-packagekitglib-1.0 \
        wl-clipboard \
        gir1.2-handy-1

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    truncate --size 0 /etc/machine-id

CMD [ "/sbin/init" ]
