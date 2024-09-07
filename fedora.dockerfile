ARG base_image=fedora-40

FROM docker.io/library/fedora:39@sha256:86ba29d15976848f8b9f27d533156d6e43553678d0832bb8ebc95ff6c2331be6 AS fedora-39
FROM docker.io/library/fedora:40@sha256:b7b4b222c2a433e831c006a49a397009640cc30e097824410a35b160be4a176b AS fedora-40

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
