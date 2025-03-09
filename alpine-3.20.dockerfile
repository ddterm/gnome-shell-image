FROM docker.io/library/alpine:3.20@sha256:de4fe7064d8f98419ea6b49190df1abbf43450c1702eeb864fe9ced453c1cc5f

COPY scripts/install-alpine.sh /usr/local/bin/
RUN /usr/local/bin/install-alpine.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
