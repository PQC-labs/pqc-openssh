FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        openssh-server \
        iproute2 \
        iputils-ping \
        vim \
        nano && \
    mkdir /var/run/sshd

RUN useradd -m -s /bin/bash researcher

RUN mkdir -p /home/researcher/.ssh && \
    chown -R researcher:researcher /home/researcher/.ssh && \
    chmod 700 /home/researcher/.ssh

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd","-D","-e"]

