FROM debianci/arm64:1710

LABEL Description="KDE Pinebook SDK"
MAINTAINER Aleix Pol Gonzalez

RUN echo "deb-src [check-valid-until=no] http://snapshot.debian.org/archive/debian/20170904/ testing main contrib non-free" >> /etc/apt/sources.list
RUN apt-get -qq update && apt-get install -qq \
    cmake \
    libxml-simple-perl \
    libjson-perl \
    ninja-build \
    build-essential \
    gperf gettext \
    wget python3-paramiko python3-lxml python3-yaml \
    *qt5*-dev qtscript5-dev qtwayland5 \
    git ccache libxrender-dev *xcb*-dev \
    libxml2-utils \
    libxslt1-dev libxslt1.1 libxxf86vm-dev docbook-xml xml-core libxml2-dev libxtst-dev \
    docbook-xsl sudo \
    flex bison libpolkit-agent-1-dev libpolkit-backend-1-dev libudev-dev libgcrypt20-dev \
    qttools5-dev-tools qttools5-dev \
    liblmdb-dev libnm-dev modemmanager-dev libnm-util-dev network-manager-dev \
    libwayland-dev xwayland libegl1-mesa-dev qtbase5-private-dev libattr1-dev libssl1.0-dev libsm-dev qtquickcontrols2-5-dev \
    libpng-dev libjpeg-dev libpng-dev libgif-dev libqrencode-dev libdmtx-dev \
    libxtst-dev libinput-dev libepoxy-dev libfontconfig1-dev libdrm-dev libxi-dev libpam-dev \
    libgrantlee5-dev libxapian-dev libxkbfile-dev libappstreamqt-dev libpackagekitqt5-dev libxcursor-dev \
   && apt-get -qq clean

RUN useradd -ms /bin/bash user
RUN mkdir /ccache && chown user /ccache

USER user

ENV PATH="/usr/lib/ccache:${PATH}"
ENV HOME /home/user/
ENV CCACHE_DIR=/ccache

COPY gitconfig $HOME/.gitconfig
COPY build-generic $HOME

WORKDIR /home/user
CMD bash $HOME/build-generic kwin plasma-desktop discover kate plasma-integration systemsettings
