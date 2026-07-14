#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# OpenSSH Native PQC Key Exchange Benchmark
#
# Measures the SSH connection establishment time for different
# Key Exchange algorithms.
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

echo "timestamp,algorithm,iteration,time_seconds,status" > "${OUTPUT}"

for ALG in "${KEX_ALGORITHMS[@]}"
do
    echo "--------------------------------------------------------"
    echo "Benchmarking ${ALG}"
    echo "--------------------------------------------------------"

    for ((i=1; i<=ITERATIONS; i++))
    do
        printf "\r[%s] %3d/%3d" "${ALG}" "${i}" "${ITERATIONS}"

        TS=$(date --iso-8601=seconds)

        START=$(date +%s.%N)

        if /opt/openssh/bin/ssh \
            -o BatchMode=yes \
            -o LogLevel=ERROR \
            -o StrictHostKeyChecking=no \
            -o UserKnownHostsFile=/dev/null \
            -o ConnectTimeout=5 \
            -o KexAlgorithms="${ALG}" \
            -i "${KEY}" \
            "${USER}@${HOST}" \
            true >/dev/null 2>&1
        then
            STATUS="OK"
        else
            STATUS="FAIL"
        fi

        END=$(date +%s.%N)

        ELAPSED=$(awk "BEGIN {printf \"%.6f\", ${END}-${START}}")

        echo "${TS},${ALG},${i},${ELAPSED},${STATUS}" >> "${OUTPUT}"
    done

    echo
    echo "Completed."
    echo
done

echo "========================================================"
echo "Benchmark completed successfully."
echo
echo "Results written to:"
echo "  ${OUTPUT}"
echo "========================================================"
