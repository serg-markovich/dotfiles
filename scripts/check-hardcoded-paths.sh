#!/usr/bin/env bash
# Fails if any dot_* file contains a hardcoded absolute home path
# instead of $HOME. Catches regressions like commit c234acb
# (/home/sergey/.kimi-code/bin instead of $HOME/.kimi-code/bin).

set -euo pipefail

FILES="$@"
FOUND=0

for f in $FILES; do
  case "$f" in
    dot_*|private_dot_*)
      if grep -nE '/home/[a-zA-Z0-9_-]+/' "$f" > /tmp/hardcoded_matches 2>/dev/null; then
        echo "FAIL: hardcoded home path found in $f"
        cat /tmp/hardcoded_matches
        echo "Use \$HOME instead of a literal username."
        FOUND=1
      fi
      ;;
  esac
done

exit $FOUND
