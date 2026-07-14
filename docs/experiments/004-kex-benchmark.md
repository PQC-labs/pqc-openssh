# Experiment 004 – Benchmark of Native Post-Quantum Key Exchange Algorithms

## Objective

The objective of this experiment is to compare the performance of the native post-quantum key exchange (KEX) algorithms available in OpenSSH 10.0p2.

Unlike the previous experiment, which validated the negotiation of hybrid post-quantum algorithms, this experiment focuses on measuring the execution time required to establish SSH sessions using different key exchange methods under identical laboratory conditions.

The benchmark provides a baseline for evaluating the computational overhead introduced by the available post-quantum hybrid algorithms.

---

## Background

Since OpenSSH 10.x includes native support for post-quantum hybrid key exchange algorithms, it is possible to compare them directly against traditional elliptic curve Diffie-Hellman without requiring external libraries.

The algorithms evaluated are:

- `curve25519-sha256`
- `sntrup761x25519-sha512@openssh.com`
- `mlkem768x25519-sha256`

All measurements were performed using the same client, server, operating system, OpenSSL version and OpenSSH build in order to isolate the impact of the key exchange algorithm.

---

## Laboratory Environment

### Host

- Ubuntu 24.04 LTS
- Docker Engine
- Docker Compose

### Client

- Ubuntu 24.04
- OpenSSH 10.0p2 (compiled from source)
- OpenSSL 3.0.13

### Server

- Ubuntu 24.04
- OpenSSH 10.0p2 (compiled from source)
- OpenSSL 3.0.13

---

## Experiment Architecture

The laboratory consists of two Docker containers connected through an isolated bridge network.

```
+--------------------+
|      Client        |
| OpenSSH 10.0p2     |
| benchmark-kex.sh   |
+---------+----------+
          |
          |
     Docker network
          |
+---------+----------+
|      Server        |
| OpenSSH 10.0p2     |
+--------------------+
```

Authentication is performed using a pre-generated ED25519 key pair mounted into both containers.

---

## Methodology

For each supported key exchange algorithm:

1. Force the desired KEX algorithm using the OpenSSH client option:

```
-o KexAlgorithms=<algorithm>
```

2. Disable password authentication.

3. Authenticate using the ED25519 key pair.

4. Execute multiple SSH connections.

5. Measure the elapsed wall-clock time for every connection.

6. Store the measurements in CSV format.

---

## Automation

Two scripts were developed as part of this experiment.

### benchmark-kex.sh

Runs repeated SSH connections for every supported key exchange algorithm and stores the raw measurements in:

```
results/raw/
```

Generated file format:

```
timestamp,algorithm,iteration,time_seconds,status
```

---

### analyze-results.py

Processes the latest benchmark CSV file and generates:

```
results/processed/summary.csv
results/processed/summary.md
```

The script computes:

- Number of samples
- Mean execution time
- Median
- Standard deviation
- Minimum value
- Maximum value

---

## Execution

Build the laboratory:

```bash
docker compose build
```

Start the containers:

```bash
docker compose up -d
```

Run the benchmark:

```bash
docker compose exec client bash

/scripts/benchmark-kex.sh 100
```

Exit the container.

Generate the statistical summary:

```bash
python3 scripts/analyze-results.py
```

---

## Example Results

Example output generated during the validation of this experiment:

| Algorithm | Mean (s) | Median (s) | StdDev |
|-----------|---------:|-----------:|--------:|
| curve25519-sha256 | 0.144132 | 0.144006 | 0.001332 |
| mlkem768x25519-sha256 | 0.144881 | 0.144756 | 0.001029 |
| sntrup761x25519-sha512@openssh.com | 0.219083 | 0.221737 | 0.006677 |

These values are provided only as an example obtained in the laboratory environment used during development.

Actual timings may vary depending on hardware, virtualization overhead and system load.

---

## Observations

The benchmark successfully demonstrates that OpenSSH allows deterministic selection of individual key exchange algorithms.

The measurement workflow is fully automated and reproducible.

Separating raw benchmark data from processed statistical summaries simplifies future analysis and enables additional tooling without modifying the benchmark itself.

---

## Conclusions

This experiment establishes a reusable benchmarking framework for evaluating native OpenSSH key exchange algorithms.

The generated CSV files can be reused for additional statistical analysis or visualization.

The methodology developed here will serve as the basis for future experiments involving:

- Performance comparison across OpenSSH versions.
- Performance comparison across hardware platforms.
- Visualization of benchmark results.
- Statistical significance analysis.
- Evaluation of future post-quantum algorithms incorporated into OpenSSH.

---

## Deliverables

The experiment produces:

- Docker laboratory
- Automated benchmark script
- Automated statistical analysis script
- Raw benchmark results (generated during execution)
- Processed statistical summaries
- Complete experiment documentation

---

## References

- OpenSSH 10.0 Release Notes
- NIST Post-Quantum Cryptography Standardization
- FIPS 203 – Module-Lattice-Based Key-Encapsulation Mechanism (ML-KEM)
