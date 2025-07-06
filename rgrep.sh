#!/bin/bash
set -e
set -u

function USAGE {
  echo 'Usage: rgrep.sh <pattern> [<file name pattern>...]' >&2
}

PATTERN=${1:-}
if [[ -z "$PATTERN" ]]; then
  USAGE
  exit 2
fi

shift
INCLUDE=
for INC_PATH in "$@"
do
  INCLUDE="$INCLUDE --include=$INC_PATH"
done

# shellcheck disable=SC2086 # Double qoutes not needed for $INCLUDE
(set -f; grep --color=auto -r $INCLUDE -- "$PATTERN" .)
