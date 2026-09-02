#!/bin/bash
set -e

IMAGE=pqc_lab002-openssh-build

echo "[+] Building OpenSSH laboratory image"

docker build \
    -t ${IMAGE} \
    -f Dockerfile \
    .

echo "[+] Build complete"
