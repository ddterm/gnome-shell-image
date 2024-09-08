ARG base_image=fedora-40

FROM docker.io/library/fedora:39@sha256:2922a1237abbb7f8517018e4f5d7a82a618f6ec09f386799e8595f9e1c39f021 AS fedora-39
FROM docker.io/library/fedora:40@sha256:5ce8497aeea599bf6b54ab3979133923d82aaa4f6ca5ced1812611b197c79eb0 AS fedora-40

FROM ${base_image}

RUN dnf install -y --nodocs --setopt install_weak_deps=False \
        gnome-session-xsession \
        gnome-extensions-app \
        gjs \
        gdm \
        vte291 \
        vte291-gtk4 \
        xorg-x11-server-Xvfb \
        mesa-dri-drivers \
        wl-clipboard \
        PackageKit \
        PackageKit-glib \
        libhandy \
    && dnf clean all -y

COPY data /

RUN systemctl set-default multi-user.target && \
    systemctl mask systemd-oomd low-memory-monitor rtkit-daemon udisks2 && \
    chmod u+rw /etc/shadow && \
    truncate --size 0 /etc/machine-id

CMD [ "/sbin/init" ]
