#!/bin/bash
# Runs the given test command, saves the full output to a log and shows only the
# relevant part. Preserves the command's real exit code.

log=$(mktemp "${TMPDIR:-/tmp}/claude-test.XXXXXX") || exit 1
"$@" >"$log" 2>&1
rc=$?

if [ "$rc" -eq 0 ]; then
  tail -n 15 "$log"
else
  grep -n -B1 -A6 -E 'FAIL|ERROR|Error:|AssertionError|✗|×|panic|failed' "$log" | head -120
  echo "--- log tail ---"
  tail -n 20 "$log"
fi
echo "[tests exit=$rc] full log: $log"
exit "$rc"
