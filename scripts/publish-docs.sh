#!/usr/bin/env bash
set -euo pipefail

# Builds the site and publishes it to the gh-pages branch, which GitHub Pages serves
# ("Deploy from a branch": gh-pages, / (root)).
#
#   scripts/publish-docs.sh             # build (strict) and publish from a clean main
#   scripts/publish-docs.sh --no-push   # build and commit to the local gh-pages branch only
#
# The build is strict: a broken internal link or a page missing from the nav stops it.

PUSH=true
for arg in "$@"; do
  case "$arg" in
    --no-push) PUSH=false ;;
    *) echo "usage: $(basename "$0") [--no-push]" >&2; exit 2 ;;
  esac
done

cd "$(dirname "${BASH_SOURCE[0]}")/.."
MKDOCS="${MKDOCS:-mkdocs}"

if [[ -n "$(git status --porcelain)" ]]; then
  echo "publish-docs.sh: working tree is dirty: commit first" >&2
  exit 1
fi
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if $PUSH && [[ "$BRANCH" != "main" && "${GITHUB_REF_NAME:-}" != "main" ]]; then
  echo "publish-docs.sh: publish from main (currently on '${BRANCH}'), or use --no-push" >&2
  exit 1
fi
SHA="$(git rev-parse --short HEAD)"

"$MKDOCS" build --strict
if $PUSH; then
  "$MKDOCS" gh-deploy --force --message "Publish the docs from ${SHA}"
else
  "$MKDOCS" gh-deploy --force --no-push --message "Publish the docs from ${SHA}"
fi
