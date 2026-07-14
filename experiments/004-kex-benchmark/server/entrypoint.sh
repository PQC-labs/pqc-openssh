#!/bin/bash
set -e

mkdir -p /opt/openssh/etc

if [ ! -f /opt/openssh/etc/ssh_host_ed25519_key ]; then
    /opt/openssh/bin/ssh-keygen \
        -t ed25519 \
        -f /opt/openssh/etc/ssh_host_ed25519_key \
        -N ""
fi

mkdir -p /home/researcher/.ssh

cp /keys/authorized_keys /home/researcher/.ssh/

chown -R researcher:researcher /home/researcher/.ssh

chmod 700 /home/researcher/.ssh
chmod 600 /home/researcher/.ssh/authorized_keys

exec /opt/openssh/sbin/sshd -D -e
