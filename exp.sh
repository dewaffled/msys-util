#!/bin/bash
set -e
set -u

if [[ $# -eq 0 ]]; then
  cygpath -wa . | while read -r path; do explorer "$path"; done
else
  for arg in "$@"; do
    cygpath -wa "$arg" | while read -r path; do explorer "$path"; done
  done
fi
