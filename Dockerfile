FROM ubuntu:16.04

ENV TERM=xterm-256color

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update; \
    apt-get install --no-install-recommends -y \
        sudo \
        build-essential \
        software-properties-common \
        devscripts \
        equivs \
        vim \
        bison \
        flex \
        librrd-dev

ARG BUILD_UID=1000
ARG BUILD_GID=1000
RUN (test $(getent group $BUILD_GID) || addgroup -gid $BUILD_GID docker) && \
    (test $(getent passwd $BUILD_UID) || adduser --disabled-password --gecos "" -uid $BUILD_UID -gid $BUILD_GID docker) && \
    adduser docker sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/docker

USER $BUILD_UID
WORKDIR /home/docker/src

