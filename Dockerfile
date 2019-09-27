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
    openjdk-8-jdk \
    subversion \
    texinfo \
	vim

## and lastly, JAVA :(
#RUN apt-get install wget java-common gnupg2 -y
#RUN echo "oracle-java11-installer shared/accepted-oracle-license-v1-2 select true" | debconf-set-selections
#RUN echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | tee /etc/apt/sources.list.d/linuxuprising-java.list
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends oracle-java11-installer && apt-get clean all

# shave some space
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# fix locales
RUN sed -i "s/^# en_GB.UTF-8/en_GB.UTF-8/" /etc/locale.gen && locale-gen && update-locale LANG=en_GB.UTF-8

WORKDIR /buildroot

# and hand over to the interactive shell
