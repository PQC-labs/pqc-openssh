FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        wget \
        curl \
        pkg-config \
        zlib1g-dev \
        libssl-dev \
        libpam0g-dev \
        libselinux1-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.0p1.tar.gz && \
    tar xzf openssh-10.0p1.tar.gz

WORKDIR /tmp/openssh-10.0p1

RUN ./configure \
        --prefix=/opt/openssh \
        --sysconfdir=/opt/openssh/etc \
        --with-ssl-engine && \
    make -j$(nproc) && \
    make install

RUN useradd -m -s /bin/bash researcher && \
    passwd -d researcher && \
    usermod -U researcher

RUN mkdir -p /var/run/sshd && \
    useradd -r -s /usr/sbin/nologin sshd

COPY sshd_config /opt/openssh/etc/sshd_config
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
