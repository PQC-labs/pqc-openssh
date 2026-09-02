# Experiment 004 – Native PQC Key Exchange Benchmark

## Objective

Conduct a benchmark and compare different PQC algorithms in a compiled version of OpenSSH, analyzing the final results after a specific number of connections.

## Laboratory architecture

```
Client Container
        │
        │ SSH (with N connections)
        ▼
Server
```

## Directory layout

```
├── client
│   ├── Dockerfile
│   └── entrypoint.sh
├── docker-compose.yml
├── README.md
├── results
│   ├── plots
│   ├── processed
│   └── raw
├── scripts
│   ├── analyze-results.py
│   └── benchmark-kex.sh
└── server
    ├── Dockerfile
    ├── entrypoint.sh
    └── sshd_config
```

## Build

```
docker compose build
```

## Start

```
docker compose up -d
```

## Execute benchmark

```
docker compose exec client bash

/scripts/benchmark-kex.sh 100
```

## Analyze results

Exit from container to Host and execute:

python3 scripts/analyze-results.py

## Generated files

results/raw/
results/processed/

## Algorithms compared

```
curve25519-sha256
sntrup761x25519-sha512@openssh.com
mlkem768x25519-sha256
```

## Expected output

(summary.csv)
(summary.md)

## Related Documentation

- Repository README
- `docs/experiments/004-kex-benchmark.md`

---

## Status

✅ Completed
