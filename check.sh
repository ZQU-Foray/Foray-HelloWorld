#!/usr/bin/env bash
set -euo pipefail
noninteractive() {
  if [ ! -t 0 ] || [ -n "${CI:-}" ] || [ -n "${GITHUB_ACTIONS:-}" ] || [ -f /.dockerenv ]; then
    echo "Yes"; else echo "No"
  fi
}

printf 'ROS=%s\nTIME=%s\nUSER=%s@%s\nNON_INTERACTIVE=%s\n' \
  "${ROS_DISTRO:-NOT_INSTALLED}" \
  "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
  "$(whoami)" "$(hostname)" \
  "$(noninteractive)"
