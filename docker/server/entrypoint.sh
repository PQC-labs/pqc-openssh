#!/bin/bash
set -e

echo "[server] configuring SSH keys"

mkdir -p /home/researcher/.ssh

cp /tmp/authorized_keys /home/researcher/.ssh/authorized_keys

chown -R researcher:researcher /home/researcher/.ssh

chmod 700 /home/researcher/.ssh
chmod 600 /home/researcher/.ssh/authorized_keys


echo "[server] starting sshd"

exec /usr/sbin/sshd -D
