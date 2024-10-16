FROM quay.io/centos/centos:stream9@sha256:70f5d98f555a6cc185d29432e7b5e1a0881c8c3e5d0d1590daa01b616d3b4048

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm && \
    dnf install -y --nodocs --setopt install_weak_deps=False \
        gnome-session-xsession \
        gnome-extensions-app \
        gjs \
        gdm \
        vte291 \
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
