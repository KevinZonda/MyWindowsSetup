#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage:
  screen-dump SESSION [WINDOW]

Examples:
  screen-dump mysession
  screen-dump mysession 0
  screen-dump 12345.pts-0.host
  screen-dump mysession > out.log
  screen-dump mysession | less

Notes:
  SESSION can be a full screen session id from `screen -ls`,
  or a partial name if it uniquely matches.
  WINDOW defaults to current window of that session.
EOF
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
  exit 2
fi

session="$1"
window="${2:-}"

tmp="$(mktemp "${TMPDIR:-/tmp}/screen-dump.XXXXXX")"
trap 'rm -f "$tmp"' EXIT

# Optional: target a specific window.
# For screen -X, the syntax is:
#   screen -S SESSION -p WINDOW -X command args...
if [[ -n "$window" ]]; then
  screen -S "$session" -p "$window" -X hardcopy -h "$tmp"
else
  screen -S "$session" -X hardcopy -h "$tmp"
fi

cat "$tmp"