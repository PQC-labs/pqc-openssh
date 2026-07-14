#!/usr/bin/env python3

"""
Analyze OpenSSH KEX benchmark results.

Reads the most recent CSV file from results/raw and generates:

    results/processed/summary.csv
    results/processed/summary.md
"""

from pathlib import Path
import csv
import statistics

BASE_DIR = Path(__file__).resolve().parent.parent

RAW_DIR = BASE_DIR / "results" / "raw"
PROCESSED_DIR = BASE_DIR / "results" / "processed"

PROCESSED_DIR.mkdir(parents=True, exist_ok=True)

csv_files = sorted(RAW_DIR.glob("kex-benchmark-*.csv"))

if not csv_files:
    raise SystemExit("No benchmark CSV files found in results/raw")

input_file = csv_files[-1]

print(f"Reading: {input_file.name}")

results = {}

with input_file.open() as f:
    reader = csv.DictReader(f)

    for row in reader:

        if row["status"] != "OK":
            continue

        alg = row["algorithm"]
        value = float(row["time_seconds"])

        results.setdefault(alg, []).append(value)

summary_csv = PROCESSED_DIR / "summary.csv"

with summary_csv.open("w", newline="") as f:

    writer = csv.writer(f)

    writer.writerow([
        "algorithm",
        "samples",
        "mean",
        "median",
        "stdev",
        "min",
        "max",
    ])

    for alg in sorted(results):

        values = results[alg]

        writer.writerow([
            alg,
            len(values),
            f"{statistics.mean(values):.6f}",
            f"{statistics.median(values):.6f}",
            f"{statistics.stdev(values):.6f}" if len(values) > 1 else "0.000000",
            f"{min(values):.6f}",
            f"{max(values):.6f}",
        ])

summary_md = PROCESSED_DIR / "summary.md"

with summary_md.open("w") as f:

    f.write("# KEX Benchmark Summary\n\n")
    f.write(f"Source file: `{input_file.name}`\n\n")

    f.write("| Algorithm | Samples | Mean (s) | Median (s) | StdDev | Min | Max |\n")
    f.write("|-----------|--------:|---------:|-----------:|-------:|----:|----:|\n")

    for alg in sorted(results):

        values = results[alg]

        stdev = statistics.stdev(values) if len(values) > 1 else 0

        f.write(
            f"| {alg} | "
            f"{len(values)} | "
            f"{statistics.mean(values):.6f} | "
            f"{statistics.median(values):.6f} | "
            f"{stdev:.6f} | "
            f"{min(values):.6f} | "
            f"{max(values):.6f} |\n"
        )

print()
print("Summary written to:")
print(f"  {summary_csv}")
print(f"  {summary_md}")
