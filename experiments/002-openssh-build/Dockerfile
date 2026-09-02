FROM ubuntu:24.04

LABEL maintainer="PQC-labs"
LABEL project="pqc-openssh"
LABEL experiment="pqc_lab002-openssh-build"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        wget \
        curl \
        git \
        pkg-config \
        libssl-dev \
        zlib1g-dev \
        libpam0g-dev \
        libselinux1-dev \
        ca-certificates \
        vim \
        less \
        bash \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.0p1.tar.gz && \
    tar xzf openssh-10.0p1.tar.gz

WORKDIR /tmp/openssh-10.0p1

RUN ./configure \
        --prefix=/opt/openssh \
        --sysconfdir=/opt/openssh/etc \
        --with-ssl-engine \
    && make -j$(nproc) \
    && make install

RUN /opt/openssh/bin/ssh -V && \
    /opt/openssh/sbin/sshd -V || true

# SSH laboratory user & sshd user for sshd daemon
RUN useradd -r -s /usr/sbin/nologin sshd && \
    useradd -m -s /bin/bash researcher && \
    passwd -d researcher && \
    usermod -U researcher && \
    mkdir -p /home/researcher/.ssh

COPY keys/authorized_keys /home/researcher/.ssh/authorized_keys

RUN chown -R researcher:researcher /home/researcher/.ssh && \
    chmod 700 /home/researcher/.ssh && \
    chmod 600 /home/researcher/.ssh/authorized_keys

# OpenSSH runtime configuration
RUN mkdir -p /opt/openssh/etc && \
    mkdir -p /opt/openssh/etc/ssh

# Generate server host keys
RUN rm -f /opt/openssh/etc/ssh_host_ed25519_key \
          /opt/openssh/etc/ssh_host_ed25519_key.pub && \
    /opt/openssh/bin/ssh-keygen \
        -t ed25519 \
        -f /opt/openssh/etc/ssh_host_ed25519_key \
        -N "" \
        -q

COPY sshd_config /opt/openssh/etc/sshd_config

CMD ["/opt/openssh/sbin/sshd", "-D", "-e", "-f", "/opt/openssh/etc/sshd_config"]
