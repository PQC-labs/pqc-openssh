FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        openssh-client \
        iproute2 \
        iputils-ping \
        vim \
        nano

CMD ["/bin/bash"]
