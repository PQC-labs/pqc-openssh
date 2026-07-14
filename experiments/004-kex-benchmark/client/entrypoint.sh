#!/bin/bash
set -e

mkdir -p /home/researcher/.ssh

cp /keys/id_ed25519* /home/researcher/.ssh/

chown -R researcher:researcher /home/researcher/.ssh

chmod 700 /home/researcher/.ssh
chmod 600 /home/researcher/.ssh/id_ed25519
chmod 644 /home/researcher/.ssh/id_ed25519.pub

exec bash
