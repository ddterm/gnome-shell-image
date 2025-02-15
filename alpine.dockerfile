ARG base_image=alpine-3.21

FROM docker.io/library/alpine:3.21@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c AS alpine-3.21
FROM docker.io/library/alpine:3.20@sha256:de4fe7064d8f98419ea6b49190df1abbf43450c1702eeb864fe9ced453c1cc5f AS alpine-3.20
FROM docker.io/library/alpine:3.19@sha256:e5d0aea7f7d2954678a9a6269ca2d06e06591881161961ea59e974dff3f12377 AS alpine-3.19
FROM docker.io/library/alpine:3.18@sha256:de0eb0b3f2a47ba1eb89389859a9bd88b28e82f5826b6969ad604979713c2d4f AS alpine-3.18

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
