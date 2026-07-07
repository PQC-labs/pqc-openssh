#!/bin/bash
set -e

docker run --rm -it \
    --name pqc-openssh-build \
    pqc-openssh-build \
    bash
