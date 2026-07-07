#!/usr/bin/env bash
#
# Project : PQC OpenSSH Lab
# Script  : collect-baseline.sh
# Purpose : Collect host environment information and generate baseline.md
#

set -euo pipefail

OUTPUT_FILE="docs/baseline.md"

mkdir -p "$(dirname "$OUTPUT_FILE")"

SSH_VERSION=$(ssh -V 2>&1)
OPENSSL_VERSION=$(openssl version)
DOCKER_VERSION=$(docker --version)
DOCKER_COMPOSE_VERSION=$(docker compose version)
GIT_VERSION=$(git --version)

HOSTNAME=$(hostname)
DATE=$(date +"%Y-%m-%d %H:%M:%S")
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
KERNEL=$(uname -r)
ARCH=$(uname -m)

CPU_MODEL=$(lscpu | awk -F: '/Model name/ {gsub(/^[ \t]+/, "", $2); print $2}')
CPU_CORES=$(nproc)
RAM=$(free -h | awk '/Mem:/ {print $2}')

cat > "$OUTPUT_FILE" <<EOF
# Baseline Environment

Generated: $DATE

---

## Host

| Item | Value |
|------|-------|
| Hostname | $HOSTNAME |
| Operating System | $OS |
| Kernel | $KERNEL |
| Architecture | $ARCH |

## Hardware

| Item | Value |
|------|-------|
| CPU | $CPU_MODEL |
| CPU Cores | $CPU_CORES |
| Memory | $RAM |

## Software

| Component | Version |
|-----------|---------|
| Git | $GIT_VERSION |
| OpenSSH | $SSH_VERSION |
| OpenSSL | $OPENSSL_VERSION |
| Docker | $DOCKER_VERSION |
| Docker Compose | $DOCKER_COMPOSE_VERSION |

## Notes

- Initial laboratory environment.
- No PQC software installed.
- No custom OpenSSH build.
EOF

echo "Baseline written to $OUTPUT_FILE"
