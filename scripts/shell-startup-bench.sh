#!/usr/bin/env bash
# bench-shell-startup.sh
# Measures bash interactive startup time over N runs. Prints median and average.

set -u

SHELL_BIN="${1:-bash}"
RUNS="${2:-20}"

if ! command -v "$SHELL_BIN" &>/dev/null; then
  echo "Error: '$SHELL_BIN' not found in PATH." >&2
  exit 1
fi

if ! [[ "$RUNS" =~ ^[0-9]+$ ]] || ((RUNS < 1)); then
  echo "Usage: $0 [shell] [number_of_runs]" >&2
  echo "  shell: bash|zsh|sh|... (default: bash)" >&2
  echo "  number_of_runs: default 20" >&2
  exit 1
fi

times_ms=()

for ((i = 1; i <= RUNS; i++)); do
  start_ns=$(date +%s%N)
  "$SHELL_BIN" -i -c exit &>/dev/null
  end_ns=$(date +%s%N)
  ms=$(((end_ns - start_ns) / 1000000))
  times_ms+=("$ms")
  printf '\rRun %d/%d: %dms   ' "$i" "$RUNS" "$ms"
done
echo

# Sort for median.
mapfile -t sorted < <(printf '%s\n' "${times_ms[@]}" | sort -n)

sum=0
for t in "${times_ms[@]}"; do
  sum=$((sum + t))
done
avg=$((sum / RUNS))

mid=$((RUNS / 2))
if ((RUNS % 2 == 0)); then
  median=$(((sorted[mid - 1] + sorted[mid]) / 2))
else
  median=${sorted[mid]}
fi

min=${sorted[0]}
max=${sorted[-1]}

echo "----------------------------------------"
printf 'Shell:  %s\n' "$SHELL_BIN"
printf 'Runs:   %d\n' "$RUNS"
printf 'Median: %dms\n' "$median"
printf 'Avg:    %dms\n' "$avg"
printf 'Min:    %dms\n' "$min"
printf 'Max:    %dms\n' "$max"
