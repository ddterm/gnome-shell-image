FROM quay.io/centos/centos:stream9@sha256:83157fe5138fa2964b2698e90ecaa43cf020a4e329653049f4bfb7b04fdde9a0

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
