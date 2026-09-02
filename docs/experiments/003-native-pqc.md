# Experiment 003 - Native Post-Quantum Cryptography in OpenSSH

## Objective

Evaluate the native post-quantum cryptographic capabilities introduced in recent OpenSSH releases, focusing on the hybrid key exchange algorithm ML-KEM-768 + X25519, without relying on external cryptographic libraries.

## Hypothesis

OpenSSH 10.x includes native support for the hybrid post-quantum key exchange algorithm `mlkem768x25519-sha256`, allowing secure SSH connections resistant to "Harvest Now, Decrypt Later" attacks while maintaining compatibility with classical elliptic-curve cryptography.

## Laboratory

Two Docker containers were created:

- OpenSSH 10.0p2 client (compiled from source)
- OpenSSH 10.0p2 server (compiled from source)

Authentication uses the same ED25519 key pair created during Experiment 001 to ensure that only the key exchange mechanism changes between experiments.

## Verification of Supported Algorithms

First, open a bash session in client:

docker compose exec client bash

The client was queried using:

/opt/openssh/bin/ssh -Q kex

Among the supported algorithms, the following native post-quantum hybrid algorithms were available:

sntrup761x25519-sha512
sntrup761x25519-sha512@openssh.com
mlkem768x25519-sha256

This confirms that the compiled OpenSSH version provides native post-quantum capabilities.

Negotiated Key Exchange

A verbose SSH connection was established using:

/opt/openssh/bin/ssh -vvv \
    -i /home/researcher/.ssh/id_ed25519 \
    researcher@server

The client reported:

debug1: kex: algorithm: mlkem768x25519-sha256

This confirms that both endpoints successfully negotiated the hybrid ML-KEM-768 + X25519 key exchange algorithm during the SSH handshake.

Initial Results

The experiment successfully demonstrates that:

OpenSSH 10.0p2 supports native post-quantum cryptography.
No external PQC libraries were required.
The negotiated algorithm was mlkem768x25519-sha256.
Public key authentication remained unchanged, proving that only the key exchange mechanism was modified.
Next Steps

The next phase will capture and analyse the SSH handshake to identify the negotiated algorithms at protocol level and compare automatic versus manually forced algorithm selection.
