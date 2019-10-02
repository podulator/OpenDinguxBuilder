FROM debian:stretch

ENV JAVA_VERSION 1.11.0

# Install mandatory dependencies
# https://buildroot.org/downloads/manual/manual.html#requirement-mandatory
RUN apt-get update && apt-get install -y -q \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    ca-certificates \
    cpio \
    debianutils \
    file \
    g++ \
    gcc \
    git \
    graphviz \
    gzip \
    libncurses5-dev \
    locales \
    make \
    patch \
    perl \
    python \
    python-matplotlib \
    rsync \
    sed \
    tar \
    unzip \
    wget

#RUN apt-cache search openjdk 
# and now our specific ones
RUN apt-get update && apt-get install -y -q \
    bison \
	bzr \
    flex \
    gcc-multilib \
    gettext \
    libc6-dev-i386 \
    mercurial \
    mlocate \
    openjdk-8-jdk \
    subversion \
    texinfo \
	vim

# shave some space
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set up toolchain
# let's get the latest from http://www.gcw-zero.com/develop

RUN mkdir -p /opt
RUN cd /opt \
	&& wget http://www.gcw-zero.com/files/opendingux-gcw0-toolchain.2014-08-20.tar.bz2 \
	&& tar jxvf ./opendingux-gcw0-toolchain.2014-08-20.tar.bz2 \
	&& rm -f ./opendingux-gcw0-toolchain.2014-08-20.tar.bz2

ENV PATH="/opt/gcw0-toolchain/usr/bin:${PATH}"

# fix locales
RUN sed -i "s/^# en_GB.UTF-8/en_GB.UTF-8/" /etc/locale.gen && locale-gen && update-locale LANG=en_GB.UTF-8

WORKDIR /buildroot

# and hand over to the interactive shell
