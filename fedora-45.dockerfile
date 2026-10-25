FROM quay.io/fedora/fedora:45 as build

# renovate: datasource=rpm depName=gjs packageName=gjs
ARG GJS_VERSION=1.90.0-1.fc45

RUN dnf install -y rpmdevtools rpm-build && \
    rpmdev-setuptree && \
    dnf download --source "gjs-$GJS_VERSION" && \
    dnf builddep -y "gjs-$GJS_VERSION.src.rpm" && \
    rpm -ivh "gjs-$GJS_VERSION.src.rpm"

RUN --mount=type=bind,source=patch/a49fcfbff25dc86d91bbd45a2b2d5d5e4d35cf58.patch,target=/root/rpmbuild/SOURCES/a49fcfbff25dc86d91bbd45a2b2d5d5e4d35cf58.patch \
    sed -i -e '/Source0:/a\' -e 'Patch: a49fcfbff25dc86d91bbd45a2b2d5d5e4d35cf58.patch' /root/rpmbuild/SPECS/gjs.spec && \
    rpmbuild --nocheck -bb /root/rpmbuild/SPECS/gjs.spec

FROM quay.io/fedora/fedora:45

# renovate: datasource=rpm depName=gnome-shell packageName=gnome-shell
ARG GNOME_SHELL_VERSION=51.0-1.fc45

# renovate: datasource=rpm depName=mutter packageName=mutter
ARG MUTTER_VERSION=51.0-1.fc45

# renovate: datasource=rpm depName=gjs packageName=gjs
ARG GJS_VERSION=1.90.0-1.fc45

# renovate: datasource=rpm depName=vte packageName=vte291
ARG VTE_VERSION=0.84.1-1.fc45

RUN --mount=type=bind,source=scripts/install-fedora.sh,target=/usr/local/bin/install-fedora.sh \
    --mount=type=bind,from=build,source=/root/rpmbuild/RPMS/x86_64,target=/root/rpmbuild/RPMS/x86_64 \
    env \
    "GNOME_SHELL_VERSION=$GNOME_SHELL_VERSION" \
    "MUTTER_VERSION=$MUTTER_VERSION" \
    "GJS_PACKAGE=/root/rpmbuild/RPMS/x86_64/gjs-$GJS_VERSION.x86_64.rpm" \
    "VTE_VERSION=$VTE_VERSION" \
    /usr/local/bin/install-fedora.sh

COPY data /

RUN --mount=type=bind,source=scripts/configure-systemd.sh,target=/usr/local/bin/configure-systemd.sh \
    /usr/local/bin/configure-systemd.sh

ENV XDG_CURRENT_DESKTOP=GNOME

CMD [ "/sbin/init" ]
