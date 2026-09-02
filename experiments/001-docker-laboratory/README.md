# Experiment 001 – Docker OpenSSH Laboratory

## Objective

Create a minimal, reproducible Docker laboratory for experimenting with OpenSSH.

This experiment establishes the common laboratory environment used throughout the repository and serves as the foundation for all subsequent Post-Quantum Cryptography experiments.

---

## Laboratory Architecture

```
Client Container
        │
        │ SSH
        ▼
Server Container
```

Both containers run Ubuntu 24.04 and communicate through an isolated Docker network.

Shared SSH keys are mounted from the repository-level `docker/keys` directory.

---

## Directory Structure

```
001-docker-laboratory/

├── client/
├── server/
├── docker-compose.yml
└── README.md
```

Shared resources:

```
docker/
└── keys/
```

---

## Requirements

- Docker Engine
- Docker Compose

---

## Running the Laboratory

From the experiment directory:

```bash
docker compose up -d
```

Verify that both containers are running:

```bash
docker compose ps
```

Expected output:

```
pqc_lab001-pqc-client   Up
pqc_lab001-pqc-server   Up
```

---

## Testing SSH Connectivity

Open a shell inside the client container:

```bash
docker compose exec client bash
```

Connect to the server:

```bash
ssh -i /keys/id_ed25519 researcher@server
```

Expected result:

```
researcher@server:~$
```

---

## Components

### Client

- Ubuntu 24.04
- OpenSSH Client
- Shared SSH private key

### Server

- Ubuntu 24.04
- OpenSSH Server
- Public key authentication

---

## Shared Resources

SSH credentials are stored outside the experiment under:

```
docker/keys/
```

This directory is shared with other experiments in the repository.

---

## Expected Outcome

A fully reproducible Docker-based OpenSSH laboratory capable of establishing authenticated SSH sessions.

This environment is reused by later experiments involving:

- OpenSSH source compilation
- Native Post-Quantum Key Exchange
- Key Exchange benchmarking

---

## Related Documentation

- Repository README
- `docs/experiments/001-docker-laboratory.md`

---

## Status

✅ Completed
