# OpenSSH Post-Quantum Cryptography Laboratory

> Reproducible engineering experiments for evaluating native Post-Quantum Cryptography support in OpenSSH.

This repository is part of the **PQC-Labs** project and contains a collection of reproducible engineering experiments focused on the adoption of **Post-Quantum Cryptography (PQC)** in OpenSSH.

Rather than implementing new cryptographic algorithms, the objective is to evaluate how modern OpenSSH versions integrate the NIST-standardized post-quantum algorithms into real-world SSH deployments.

Every experiment is self-contained, fully documented and reproducible using Docker.

---

# Objectives

The laboratory focuses on the following goals:

- Build reproducible OpenSSH laboratory environments.
- Study native Post-Quantum Cryptography support.
- Benchmark cryptographic performance.
- Validate interoperability between algorithms.
- Analyze SSH protocol behavior.
- Produce practical engineering documentation.

---

# Repository Structure

```
pqc-openssh
│
├── docker/                Shared Docker resources
├── docs/                  Technical documentation
├── experiments/           Independent laboratory experiments
├── results/               Global project results
├── scripts/               Shared utility scripts
└── README.md
```

Each experiment is completely independent and includes its own environment, execution procedure and documentation.

---

# Completed Experiments

| Experiment | Description | Status |
|------------|-------------|--------|
| **001** | Docker laboratory for OpenSSH | ✅ Complete |
| **002** | Build OpenSSH from source | ✅ Complete |
| **003** | Native Post-Quantum Key Exchange validation | ✅ Complete |
| **004** | Key Exchange performance benchmark | ✅ Complete |

Detailed documentation is available under:

```
docs/experiments/
```

---

# Current Status

| Area | Status |
|------|--------|
| Docker laboratory | ✅ |
| OpenSSH source build | ✅ |
| Native ML-KEM support | ✅ |
| Native SNTRUP support | ✅ |
| Hybrid Key Exchange validation | ✅ |
| Performance benchmarking | ✅ |
| Protocol analysis | 🚧 Planned |
| Interoperability testing | 🚧 Planned |

---

# Quick Start

Clone the repository:

```bash
git clone https://github.com/PQC-labs/pqc-openssh.git

cd pqc-openssh
```

Run one of the experiments:

```bash
cd experiments/004-kex-benchmark

docker compose up -d
```

Each experiment contains its own documentation describing:

- Objectives
- Background
- Environment
- Methodology
- Execution
- Results
- Conclusions

---

# Laboratory Architecture

```
                +----------------------+
                |     Researcher       |
                +----------+-----------+
                           |
                           |
                    Docker Compose
                           |
        +------------------+------------------+
        |                                     |
+---------------+                    +---------------+
| SSH Client    |                    | SSH Server    |
| OpenSSH 10.x  | <----------------> | OpenSSH 10.x  |
| PQC Enabled   |      SSH Session   | PQC Enabled   |
+---------------+                    +---------------+

```

Experiments reuse the same architecture while focusing on different engineering objectives.

---

# Technologies

The laboratory currently uses:

- OpenSSH 10.x
- ML-KEM (FIPS 203)
- SNTRUP761
- OpenSSL
- Docker
- Ubuntu
- Bash
- Python
- Wireshark
- tcpdump

Additional technologies will be incorporated as new experiments are developed.

---

# Documentation

Project documentation is organized as follows:

```
docs/
│
├── experiments/
│     ├── 001-laboratory.md
│     ├── 002-openssh-build.md
│     ├── 003-native-pqc.md
│     └── 004-kex-benchmark.md
│
└── scripts/
│     ├── 001-Baseline Collection.md

```

Each experiment documents:

- Objectives
- Environment
- Methodology
- Execution procedure
- Results
- Conclusions

Scripts:
 
The scripts folder contains documentation on general-purpose scripts for all experiments.

---

# Roadmap

## Completed

- ✅ Docker-based OpenSSH laboratory
- ✅ OpenSSH native compilation
- ✅ Native ML-KEM validation
- ✅ Hybrid Key Exchange validation
- ✅ KEX performance benchmark

## Planned

- ⏳ SSH packet capture
- ⏳ Wireshark protocol analysis
- ⏳ CPU profiling
- ⏳ Memory profiling
- ⏳ Multi-host benchmarks
- ⏳ Cross-version interoperability
- ⏳ Quantum-safe deployment recommendations

---

# Related Project

This repository is part of the **PQC-Labs** engineering laboratory.

Current repositories:

| Repository | Description |
|------------|-------------|
| **pqc-lab** | Laboratory index and roadmap |
| **pqc-openssh** | Native OpenSSH Post-Quantum experiments |

Future repositories include:

- pqc-openssl
- pqc-liboqs
- pqc-oqs-provider
- pqc-tls
- pqc-wireguard
- pqc-vpn
- pqc-python

---

# Contributing

Suggestions, issues and pull requests are welcome.

If you discover an issue or have ideas for additional experiments, please open an Issue.

---

# License

MIT License
