FROM ubuntu:18.04
MAINTAINER ARC-TS <arcts-dev@umich.edu>

ARG BUILD_DATE
ARG SINGULARITY_VERSION
ARG VCS_REF
ARG VERSION

LABEL architecture="x86_64"                                \
      build-date="$BUILD_DATE"                             \
      license="MIT"                                        \
      name="arcts/singularity-util"                        \
      summary="Docker based wrapper for Singularity"       \
      version="$VERSION"                                   \
      vcs-ref="$VCS_REF"                                   \
      vcs-type="git"                                       \
      vcs-url="https://github.com/dPys/singularity-util.git" \
      singularity.version="$SINGULARITY_VERSION"

RUN apt-get update     \
 && apt-get -y install \
    autoconf        \
    automake        \
    autotools-dev   \
    build-essential \
    debootstrap     \
    debhelper       \
    dh-autoreconf   \
    git             \
    help2man        \
    libarchive-dev  \
    libtool         \
    python          \
    rpm             \
    sudo            \
    squashfs-tools  \
    curl	    \
 && mkdir build     \
 && mkdir target    \
 && chmod -R 777 /target \
 && apt-get -y autoremove \
 && apt-get -y clean      \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./skel /

RUN chmod +x ./build.sh \
 && sync \
 && chmod +x ./init.sh  \
 && sync \
 && ./build.sh \
 && curl https://raw.githubusercontent.com/cinek810/singularity/13a0b2e97b25e9324eb0450cf36df8a667e1556b/libexec/cli/image.expand.exec > /usr/local/libexec/singularity/cli/image.expand.exec

USER root

RUN chown root:root /usr/local/libexec/singularity/bin/action-suid \
 && chmod 4755 /usr/local/libexec/singularity/bin/action-suid

ENTRYPOINT [ "./init.sh" ]
