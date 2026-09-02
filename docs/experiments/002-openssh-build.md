## Experiment 002 — Building OpenSSH 10.0p2 from Source

Project: PQC OpenSSH Laboratory

Status: Completed

Date: July 2026

# 1. Objective

The purpose of this experiment was to build a recent version of OpenSSH from its official source code instead of relying on the version provided by the Ubuntu package repositories.

This experiment provides a controlled environment where future Post-Quantum Cryptography (PQC) features can be evaluated independently of the operating system distribution.

The resulting Docker image will be reused during subsequent experiments.

# 2. Motivation

Ubuntu 24.04 already ships a modern OpenSSH version (9.6p1), which supports the hybrid key exchange algorithm:

sntrup761x25519-sha512

However, recent OpenSSH releases introduce additional cryptographic improvements, including:

ML-KEM hybrid key exchange
Updated defaults
Latest protocol improvements
Better alignment with the current OpenSSH upstream project

Compiling OpenSSH directly from source guarantees full control over the software version used during the research.

# 3. Laboratory Environment

Host operating system

Ubuntu 24.04 LTS

Docker image

ubuntu:24.04

OpenSSH source

OpenSSH Portable 10.0p2

Installation prefix

/opt/openssh

The system OpenSSH installation remains untouched.

# 4. Building OpenSSH

The official OpenSSH Portable source archive was downloaded from OpenBSD.

Example:

wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.0p1.tar.gz
tar xzf openssh-10.0p1.tar.gz

cd openssh-10.0p1

./configure \
    --prefix=/opt/openssh \
    --sysconfdir=/opt/openssh/etc \
    --with-ssl-engine

make -j$(nproc)

make install

The installation completed successfully.

# 5. Docker Image

A dedicated Docker image was created specifically for this experiment.

The image contains:

Ubuntu 24.04
OpenSSH 10.0p2
OpenSSL 3.0
researcher user
sshd privilege separation user
server configuration
host keys
public key authentication

Unlike Experiment 001, this image is intended exclusively for OpenSSH development and protocol analysis.

# 6. SSH Server Configuration

A custom sshd_config was installed under:

/opt/openssh/etc/sshd_config

Important settings:

Port 2222

PermitRootLogin no

PasswordAuthentication no

PubkeyAuthentication yes

AuthorizedKeysFile .ssh/authorized_keys

AllowUsers researcher

The server is started using:

/opt/openssh/sbin/sshd \
    -D \
    -f /opt/openssh/etc/sshd_config

# 7. User Configuration

A dedicated research account was created.

researcher

The account was configured with:

home directory
Bash shell
unlocked password database entry
.ssh directory
authorized_keys

The public key generated during Experiment 001 was copied into the container.

This allows using exactly the same client identity throughout the project.

# 8. Host Keys

Host keys are generated during the Docker image build.

Example:

rm -f /opt/openssh/etc/ssh_host_ed25519_key*

/opt/openssh/bin/ssh-keygen \
    -t ed25519 \
    -f /opt/openssh/etc/ssh_host_ed25519_key \
    -N ""

This guarantees the server always starts with valid host keys.

# 9. Public Key Authentication

The existing ED25519 key pair from Experiment 001 was reused.

Authentication was verified using:

ssh \
    -p 2222 \
    -i docker/keys/id_ed25519 \
    researcher@localhost

Successful login confirmed:

key ownership
permissions
AuthorizedKeys configuration
SSH daemon configuration

# 10. OpenSSH Validation

Installed version:

/opt/openssh/bin/ssh -V

Output:

OpenSSH_10.0p2

Supported Key Exchange algorithms:

/opt/openssh/bin/ssh -Q kex

Relevant algorithms include:

curve25519-sha256

sntrup761x25519-sha512

sntrup761x25519-sha512@openssh.com

mlkem768x25519-sha256

The presence of ML-KEM confirms that the compiled version already includes the new hybrid post-quantum key exchange introduced by OpenSSH.

# 11. Issues Encountered

Several issues were identified during the experiment.

1. Locked user account: Initially the researcher account was created in a locked state.
2. The SSH server rejected authentication with: User researcher not allowed because account is locked. The issue was solved by unlocking the account during image creation.
3. Missing privilege separation user: The SSH daemon initially reported: Privilege separation user sshd does not exist (A dedicated system user was added to the image).
4. Existing host keys: Rebuilding the Docker image caused ssh-keygen to request confirmation before overwriting existing keys. The solution was to remove any previous keys before generating new ones.
5. Public key deployment: Initially the authorized public key had to be copied manually into the container. The final Docker image copies the public key automatically during the build process, making the environment completely reproducible.

# 12. Results

The experiment successfully produced:

OpenSSH 10.0p2 compiled from source
isolated Docker image
reproducible build
public key authentication
custom server configuration
reusable environment for future PQC experiments

The resulting image provides a clean platform for protocol analysis without modifying the host operating system.

# 13. Conclusions

Experiment 002 establishes a modern OpenSSH environment independent of the Ubuntu packages.

This environment exposes the latest hybrid key exchange algorithms already integrated into OpenSSH, including ML-KEM.

Having a reproducible build also enables future experiments involving:

algorithm selection
protocol negotiation
packet capture
benchmarking
interoperability testing
Open Quantum Safe integration

# 14. Next Experiment

The next experiment focuses on analysing the negotiated key exchange algorithms during SSH connections.

Particular attention will be given to the new hybrid mechanisms:

sntrup761x25519-sha512
mlkem768x25519-sha256

These algorithms will be validated through verbose SSH sessions, packet captures and protocol inspection to understand how OpenSSH negotiates post-quantum hybrid key exchange in practice.
