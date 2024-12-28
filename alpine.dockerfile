ARG base_image=alpine-3.21

FROM docker.io/library/alpine:3.21@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45 AS alpine-3.21
FROM docker.io/library/alpine:3.20@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a AS alpine-3.20
FROM docker.io/library/alpine:3.19@sha256:7a85bf5dc56c949be827f84f9185161265c58f589bb8b2a6b6bb6d3076c1be21 AS alpine-3.19
FROM docker.io/library/alpine:3.18@sha256:2995c82e8e723d9a5c8585cb8e901d1c50e3c2759031027d3bff577449435157 AS alpine-3.18

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

CMD [ "/sbin/init" ]
