ARG base_image=ubuntu-24.04

FROM docker.io/library/debian:12@sha256:aadf411dc9ed5199bc7dab48b3e6ce18f8bbee4f170127f5ff1b75cd8035eb36 AS debian-12
FROM docker.io/library/debian:trixie@sha256:0c75aed52e3a564e27c3aaba51b0a7e59ac21dd09abcb25f2fe0b9b37c8f7e01 AS debian-13
FROM docker.io/library/ubuntu:24.04@sha256:8a37d68f4f73ebf3d4efafbcf66379bf3728902a8038616808f04e34a9ab63ee AS ubuntu-24.04

FROM ${base_image}

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gnome-session \
        gjs \
        dbus-user-session \
        gdm3 \
        gir1.2-vte-2.91 \
        gir1.2-vte-3.91 \
        xvfb \
        packagekit \
        gir1.2-packagekitglib-1.0 \
        wl-clipboard \
        gir1.2-handy-1

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    useradd -m -U -G users,adm gnomeshell && \
    truncate --size 0 /etc/machine-id && \
    dconf update

CMD [ "/sbin/init" ]
