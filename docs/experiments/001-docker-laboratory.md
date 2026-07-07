# Experiment 001 – Build a Reproducible Docker Laboratory for OpenSSH

## Objective

Create a reproducible Docker-based laboratory that will serve as the foundation for all OpenSSH and Post-Quantum Cryptography experiments.

The laboratory must be completely isolated from the host operating system and reproducible on any Ubuntu 24.04 system with Docker installed.

## Motivation

Future experiments will require compiling different OpenSSH versions, replacing OpenSSL, integrating liboqs and testing Post-Quantum Key Exchange algorithms.

Performing these tasks directly on the host operating system would make the environment difficult to reproduce and maintain.

A containerized laboratory provides:

- Reproducibility
- Isolation
- Easy cleanup
- Version control of the environment
- Safe experimentation

## Target Architecture

Host Ubuntu 24.04
        │
        ▼
Docker Engine
        │
        ▼
Docker Network (pqc-openssh-net)
        │
 ┌──────────────┐      SSH      ┌──────────────┐
 │ ssh-client   │ <-----------> │ ssh-server   │
 │ Ubuntu 24.04 │               │ Ubuntu 24.04 │
 └──────────────┘               └──────────────┘

## Success Criteria

- Docker network created.
- Client container running.
- Server container running.
- OpenSSH Server operational.
- Successful SSH connection from client to server.

## Start

docker compose up -d

## Check Status

docker compose ps

## SSH Connection Test

Enter client container: docker compose exec client bash
Connect: ssh researcher@server


Expected result:

A shell on the server container without password authentication.

## Security Configuration

The server disables:

- Root login
- Password authentication

Only public key authentication is allowed.

## Experiment Result

The Docker laboratory is operational.

The environment is ready for future experiments involving:

- OpenSSH compilation
- cryptographic algorithm testing
- post-quantum cryptography integration

## Known implementation details

The researcher user is explicitly unlocked during image creation because Ubuntu
may create new users in a locked state. OpenSSH refuses authentication for locked
accounts even when valid public keys are configured.

## Conclusion

Experiment 001 establishes a reproducible and isolated OpenSSH laboratory.

Future experiments will modify the cryptographic stack while keeping this infrastructure unchanged.


