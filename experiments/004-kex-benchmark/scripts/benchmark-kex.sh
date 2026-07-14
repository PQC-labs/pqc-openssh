#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# OpenSSH Native PQC Key Exchange Benchmark
#
# Description:
#   Measures the SSH connection establishment time for different
#   Key Exchange (KEX) algorithms supported by OpenSSH.
#
# Usage:
#   ./benchmark-kex.sh [iterations]
#
# Example:
#   ./benchmark-kex.sh 100
#
###############################################################################

ITERATIONS="${1:-50}"

USER="researcher"
HOST="server"
KEY="/home/researcher/.ssh/id_ed25519"

RESULTS_DIR="/results/raw"
mkdir -p "${RESULTS_DIR}"

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
OUTPUT="${RESULTS_DIR}/kex-benchmark-${TIMESTAMP}.csv"

KEX_ALGORITHMS=(
    "curve25519-sha256"
    "sntrup761x25519-sha512@openssh.com"
    "mlkem768x25519-sha256"
)

echo "========================================================"
echo " OpenSSH Native PQC Key Exchange Benchmark"
echo "========================================================"
echo
echo "Target host : ${HOST}"
echo "User        : ${USER}"
echo "Iterations  : ${ITERATIONS}"
echo "Output file : ${OUTPUT}"
echo

echo "timestamp,algorithm,iteration,time_seconds" > "${OUTPUT}"

for ALG in "${KEX_ALGORITHMS[@]}"
do
    echo "--------------------------------------------------------"
    echo "Benchmarking ${ALG}"
    echo "--------------------------------------------------------"

    for ((i=1; i<=ITERATIONS; i++))
    do
        printf "\r[%s] %3d/%3d" "${ALG}" "${i}" "${ITERATIONS}"

        START=$(date --iso-8601=seconds)

        TIME=$(
            /usr/bin/time -f "%e" \
            /opt/openssh/bin/ssh \
                -o BatchMode=yes \
                -o LogLevel=ERROR \
                -o StrictHostKeyChecking=no \
                -o UserKnownHostsFile=/dev/null \
                -o ConnectTimeout=5 \
                -o KexAlgorithms="${ALG}" \
                -i "${KEY}" \
                "${USER}@${HOST}" \
                exit \
            >/dev/null 2>&1
        )

        echo "${START},${ALG},${i},${TIME}" >> "${OUTPUT}"
    done

    echo
    echo "Completed."
    echo
done

echo "========================================================"
echo "Benchmark completed successfully."
echo
echo "Raw results:"
echo "  ${OUTPUT}"
echo "========================================================"
