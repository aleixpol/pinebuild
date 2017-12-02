FROM pangea/debian:17.10

LABEL Description="KDE Pinebook SDK"
MAINTAINER Aleix Pol Gonzalez

COPY gitconfig $HOME/.gitconfig
COPY build-generic $HOME
RUN apt-get -qq update && apt-get install -qq \
    cmake \
    libxml-simple-perl \
    libjson-perl \
    ninja-build \
    build-essential \
    gperf gettext \
    python3 \
    && apt-get -qq clean

RUN git clone kde:sysadmin/ci-tooling

CMD bash $HOME/build-generic kwin plasma-desktop discover
