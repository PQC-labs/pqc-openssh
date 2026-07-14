#!/bin/bash
set -e

echo "[client] configuring SSH"

mkdir -p /home/researcher/.ssh

chmod 700 /home/researcher/.ssh

chmod 600 /home/researcher/.ssh/id_ed25519 || true
chmod 644 /home/researcher/.ssh/id_ed25519.pub || true

echo "[client] ready"

exec tail -f /dev/null
