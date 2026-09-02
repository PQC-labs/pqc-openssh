# Experiment 004 – Native PQC Key Exchange Benchmark

## Objective

## Laboratory architecture

## Directory layout

## Build

docker compose build

## Start

docker compose up -d

## Execute benchmark

docker compose exec client bash

/scripts/benchmark-kex.sh 100

## Analyze results

exit

python3 scripts/analyze-results.py

## Generated files

results/raw/
results/processed/

## Algorithms compared

curve25519-sha256
sntrup761x25519-sha512@openssh.com
mlkem768x25519-sha256

## Expected output

(summary.csv)

(summary.md)


## Related Documentation

- Repository README
- `docs/experiments/004-kex-benchmark.md`

---

## Status

✅ Completed
