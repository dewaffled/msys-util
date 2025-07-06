#!/bin/bash
set -e
set -u

function USAGE {
  echo 'Usage: find-any.sh <root> <pattern...>' >&2
}

SEARCH_ROOT="${1:-}"
shift

TERM="${1:-}"
if [[ -z "$SEARCH_ROOT" ]] || [[ -z "$TERM" ]]; then
  USAGE
  exit 2
fi

FILTER="$TERM"
FILES=$(find "$SEARCH_ROOT" -type f | grep -i "$TERM")

shift
while [[ $# -gt 0 ]]; do
  TERM=$1
  FILTER="$FILTER|$TERM"
  FILES=$(echo "$FILES" | grep -i "$TERM")
  shift
done

if [[ -n "$FILES" ]]; then
  echo "$FILES" | grep --color=auto -Pi "$FILTER"
fi
