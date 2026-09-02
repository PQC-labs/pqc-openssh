# Experiment 002 - OpenSSH Build Laboratory

## Objective

Build OpenSSH from source inside a controlled Ubuntu 24.04 environment.

This experiment prepares the environment required for future post-quantum
cryptography integration.

## Current status

Phase 1:
- Ubuntu 24.04 base
- OpenSSH source compilation
- Installation under /opt/openssh

## Expected binaries

/opt/openssh/bin/ssh

/opt/openssh/bin/ssh-keygen

/opt/openssh/sbin/sshd

## Deployment

First, we build the image using the script: ./build-openssh.sh
Then we create the container: ./run-sshd.sh

See the documentation in docs/experiments/002-openssh-build for the results and the issues encountered.

## Validation

The experiment was successfully validated with:

- OpenSSH compiled from source
- Custom sshd running on port 2222
- researcher user authentication
- ED25519 public key authentication

The server uses:

/opt/openssh/sbin/sshd
