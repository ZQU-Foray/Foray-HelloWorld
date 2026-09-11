#!/usr/bin/env bash
set -euo pipefail

hostname_value() {
  if command -v hostname >/dev/null 2>&1; then
    hostname
  elif [ -n "${HOSTNAME:-}" ]; then
    echo "$HOSTNAME"
  elif command -v uname >/dev/null 2>&1; then
    uname -n
  elif [ -r /proc/sys/kernel/hostname ]; then
    cat /proc/sys/kernel/hostname
  elif [ -r /etc/hostname ]; then
    cat /etc/hostname
  else
    echo unknown
  fi
}

noninteractive() {
  if [ ! -t 0 ] || [ -n "${CI:-}" ] || [ -n "${GITHUB_ACTIONS:-}" ] || [ -f /.dockerenv ]; then
    echo "Yes"; else echo "No"
  fi
}

printf 'ROS=%s\nTIME=%s\nUSER=%s@%s\nNON_INTERACTIVE=%s\n' \
  "${ROS_DISTRO:-NOT_INSTALLED}" \
  "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
  "$(whoami)" "$(hostname_value)" \
  "$(noninteractive)"
