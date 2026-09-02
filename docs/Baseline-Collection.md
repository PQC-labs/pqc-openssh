### Baseline Environment Collection

## Overview

collect-baseline.sh is a Bash script used by the PQC OpenSSH Lab to collect and record the baseline environment of the host system before performing experiments.

The purpose of the baseline is to provide a reproducible reference of the hardware, operating system, kernel, and relevant software versions used during an experiment.

The generated baseline is stored as a Markdown file under:

results/baselines/

Each execution creates a new timestamped file, allowing multiple baseline snapshots to be retained.

## Purpose

The script captures the following information:

Host identification and operating system information.
CPU model and number of available CPU cores.
Total system memory.
Architecture and kernel version.
Versions of Git, OpenSSH, OpenSSL, Docker, and Docker Compose.

This information can be used to:

Document the environment in which an experiment was executed.
Compare results obtained on different machines.
Identify differences between experimental environments.
Support reproducibility and troubleshooting.
Establish a reference point before installing or building PQC-related software.

## Requirements

The script requires a Linux environment with the following commands available:

bash
hostname
date
ssh
openssl
docker
git
grep
cut
tr
uname
lscpu
awk
nproc
free
Docker Compose must be available through the Docker CLI:
docker compose version

The script does not require sudo privileges under normal circumstances.

## Usage

From the project root, execute:

./collect-baseline.sh

If the script does not have execute permissions, they can be added with:

chmod +x collect-baseline.sh

The script should be executed from the project root because the output directory is defined using a relative path:

results/baselines

## Output

The script creates the following directory if it does not already exist:

results/baselines/

A new Markdown file is generated for every execution using the following naming convention:

<hostname>-<timestamp>.md

For example:

results/baselines/hidra-ctl-00-20260902-104300.md

The timestamp used in the filename follows the format:

YYYYMMDD-HHMMSS

This allows multiple baseline snapshots to coexist without overwriting previous results.

## Generated Document

Each generated baseline contains four main sections.

Host

The host section records information about the operating system and execution environment:

Item	Description
Hostname	Name of the machine running the script
Operating System	Linux distribution and release
Kernel	Running Linux kernel version
Architecture	System architecture, e.g. x86_64

Example:

## Host

| Item | Value |
|------|-------|
| Hostname | hidra-ctl-00 |
| Operating System | Ubuntu 24.04 LTS |
| Kernel | 6.8.0-xx-generic |
| Architecture | x86_64 |

Hardware

The hardware section records the main CPU and memory characteristics:

Item	Description
CPU	CPU model reported by lscpu
CPU Cores	Number of processors reported by nproc
Memory	Total system memory reported by free

Example:

## Hardware

| Item | Value |
|------|-------|
| CPU | Intel(R) Xeon(R) CPU ... |
| CPU Cores | 32 |
| Memory | 125Gi |

Software

The software section records the versions of the tools relevant to the PQC OpenSSH experiments:

Component	Command
Git	git --version
OpenSSH	ssh -V
OpenSSL	openssl version
Docker	docker --version
Docker Compose	docker compose version

Example:

## Software

| Component | Version |
|-----------|---------|
| Git | git version 2.x.x |
| OpenSSH | OpenSSH_9.xp1 |
| OpenSSL | OpenSSL 3.x.x |
| Docker | Docker version 28.x.x |
| Docker Compose | Docker Compose version v2.x.x |

## Notes

The generated document currently includes the following notes:

- Initial laboratory environment.
- No PQC software installed.
- No custom OpenSSH build.

These notes describe the intended state of the host when establishing the initial baseline.

Output Directory and Git

Baseline results are considered local experimental artifacts and should not be committed to the repository.

The project keeps the directory structure in Git using a .gitkeep file:

results/
└── baselines/
    └── .gitkeep

Generated baseline files are ignored through .gitignore:

results/baselines/*
!results/baselines/.gitkeep

Therefore, running the script produces local files such as:

results/baselines/
├── .gitkeep
├── server1-20260902-104300.md
└── server2-20260902-153012.md

Only .gitkeep is tracked by Git.

This prevents potentially machine-specific information from being accidentally published to the GitHub repository.

## Script Behaviour

The script uses:

set -euo pipefail

This enables stricter Bash error handling:

-e: exits when a command fails.
-u: treats unset variables as errors.
pipefail: causes a pipeline to fail if any command in the pipeline fails.

## The output directory is created automatically:

mkdir -p "$OUTPUT_DIR"

The baseline filename is constructed using the hostname and execution timestamp:

OUTPUT_FILE="${OUTPUT_DIR}/${HOSTNAME}-${DATE}.md"

Finally, the Markdown document is generated using a Bash heredoc and written directly to the output file.

## Workflow

A typical workflow is:

1. Start with a clean host environment
          ↓
2. Run collect-baseline.sh
          ↓
3. Record hardware/software baseline locally
          ↓
4. Build/install experimental software
          ↓
5. Run PQC/OpenSSH experiments
          ↓
6. Collect experiment results
          ↓
7. Compare results with the baseline

The baseline therefore acts as an environmental reference for the experiments conducted in the laboratory.

## Limitations

The script currently collects only a basic set of host characteristics. It does not capture:

Detailed CPU topology.
CPU frequency information.
NUMA configuration.
Detailed memory configuration.
Storage devices or filesystem information.
Network interface configuration.
GPU information.
Docker daemon configuration.
Running Docker containers.
Installed PQC libraries or cryptographic providers.
OpenSSH configuration files.
OpenSSL configuration.
Environment variables.
Current system load.

These items can be added in future versions if they become relevant to the experimental methodology.

## Reproducibility Considerations

The baseline should ideally be collected:

Before installing experimental software.
Before building a custom OpenSSH version.
Before modifying the cryptographic environment.
On every host used for performance comparisons.

When comparing experimental results between hosts, the corresponding baseline files should be consulted to identify hardware or software differences that could influence the results.