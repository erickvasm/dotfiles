#!/bin/bash

# Autenticar sudo antes de fzf
sudo -v || exit 1

ENTRY=$(
sudo lsof -nP -iTCP -sTCP:LISTEN | tail -n +2 | \
awk '{
  port=""
  for (i=1; i<=NF; i++) {
    if ($i ~ /:[0-9]+$/) {
      split($i, a, ":")
      port=a[2]
    }
  }
  if (port != "")
    printf "%-15s %s\n", $1, port
}' | \
sort -u | \
fzf --height 100% \
    --header="COMMAND         PORT" \
    --preview='lsof -nP -p $(lsof -tiTCP:'"'"'{2}'"'"')' \
    --preview-window=right:65%
)

[ -z "$ENTRY" ] && exit 0

PORT=$(echo "$ENTRY" | awk '{print $2}')

echo "Matando proceso en puerto $PORT"
sudo lsof -tiTCP:"$PORT" | xargs sudo kill -9