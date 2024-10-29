FROM quay.io/centos/centos:stream9@sha256:e5fdd83894773a25f22fbdf0b5253c63677d0cbaf8d3a8366b165a3ef5902964

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
