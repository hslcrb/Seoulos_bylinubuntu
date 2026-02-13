#!/usr/bin/env bash
set -euo pipefail
TARGET="COLABORATION.md"
LOG_TAG="[watch-collab]"

notify() {
  local msg="$1"
  echo "${LOG_TAG} $(date -u +%FT%TZ) ${msg}"
}

notify "started; monitoring close_write on ${TARGET}" || true

while true; do
  if [ ! -f "$TARGET" ]; then
    notify "waiting for ${TARGET} to exist" || true
    inotifywait -q -e create -e moved_to -e close_write . >/dev/null 2>&1 || true
    continue
  fi

  inotifywait -q -e close_write "$TARGET" >/dev/null 2>&1 || true
  notify "${TARGET} updated" || true
  sleep 0.1
done
