ARG base_image=alpine-3.21

FROM docker.io/library/alpine:3.21@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099 AS alpine-3.21
FROM docker.io/library/alpine:3.20@sha256:31687a2fdd021f85955bf2d0c2682e9c0949827560e1db546358ea094f740f12 AS alpine-3.20
FROM docker.io/library/alpine:3.19@sha256:6380aa6b04faa579332d4c9d1f65bd7093012ba6e01d9bbcd5e2d8a4f9fae38f AS alpine-3.19
FROM docker.io/library/alpine:3.18@sha256:dd60c75fba961ecc5e918961c713f3c42dd5665171c58f9b2ef5aafe081ad5a0 AS alpine-3.18

FROM ${base_image}
ARG base_image

RUN apk add \
        xvfb \
        xinit \
        elogind \
        polkit-elogind \
        mesa \
        mesa-dri-gallium \
        gnome-shell \
        gdm \
        vte3 \
        vte3-gtk4 \
        libhandy1 \
        wl-clipboard \
    && rm -rf /var/cache/apk/*

RUN sed -i '/getty/d' /etc/inittab && \
    rc-update add elogind && \
    rc-update add polkit

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
