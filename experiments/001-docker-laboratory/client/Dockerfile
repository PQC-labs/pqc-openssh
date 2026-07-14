FROM ubuntu:24.04

LABEL maintainer="PQC-labs"
LABEL project="pqc-openssh"
LABEL role="ssh-client"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        openssh-client \
        bash \
        iproute2 \
        iputils-ping \
        net-tools \
        procps \
        vim \
        less \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN useradd -m -s /bin/bash researcher && \
    passwd -d researcher && \
    usermod -U researcher && \
    mkdir -p /home/researcher/.ssh && \
    chown -R researcher:researcher /home/researcher/.ssh && \
    chmod 700 /home/researcher/.ssh

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
