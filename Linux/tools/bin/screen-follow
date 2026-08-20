#!/usr/bin/env bash
set -euo pipefail

session="${1:?Usage: screen-follow SESSION [WINDOW]}"
window="${2:-}"
interval="${SCREEN_FOLLOW_INTERVAL:-1}"

tmp="$(mktemp "${TMPDIR:-/tmp}/screen-follow.XXXXXX")"
trap 'rm -f "$tmp"' EXIT

while true; do
  if [[ -n "$window" ]]; then
    screen -S "$session" -p "$window" -X hardcopy -h "$tmp"
  else
    screen -S "$session" -X hardcopy -h "$tmp"
  fi

  clear
  cat "$tmp"
  sleep "$interval"
done