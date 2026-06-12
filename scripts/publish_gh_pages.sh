#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REMOTE="${1:-origin}"
PUBLISH_BRANCH="gh-pages"
SITE_DIR="$ROOT_DIR/_site"

cd "$ROOT_DIR"

if ! command -v quarto >/dev/null 2>&1; then
  printf 'quarto is required but was not found on PATH.\n' >&2
  exit 1
fi

printf 'Rendering Quarto site...\n'
quarto render

if [[ ! -d "$SITE_DIR" ]]; then
  printf 'Expected rendered site at %s, but it was not created.\n' "$SITE_DIR" >&2
  exit 1
fi

WORKTREE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/comp331-gh-pages.XXXXXX")"
cleanup() {
  git worktree remove --force "$WORKTREE_DIR" >/dev/null 2>&1 || true
}
trap cleanup EXIT

if git ls-remote --exit-code --heads "$REMOTE" "$PUBLISH_BRANCH" >/dev/null 2>&1; then
  git fetch "$REMOTE" "$PUBLISH_BRANCH:$PUBLISH_BRANCH" >/dev/null 2>&1 || true
  git worktree add --force -B "$PUBLISH_BRANCH" "$WORKTREE_DIR" "$REMOTE/$PUBLISH_BRANCH"
else
  git worktree add --force --detach "$WORKTREE_DIR"
  (
    cd "$WORKTREE_DIR"
    git checkout --orphan "$PUBLISH_BRANCH"
    git rm -rf . >/dev/null 2>&1 || true
  )
fi

(
  cd "$WORKTREE_DIR"
  git rm -rf . >/dev/null 2>&1 || true
  cp -R "$SITE_DIR/." "$WORKTREE_DIR/"
  touch .nojekyll
  git add -A

  if git diff --cached --quiet; then
    printf 'No published site changes to push.\n'
    exit 0
  fi

  git commit -m "publish site"
  git push "$REMOTE" "$PUBLISH_BRANCH"
)

printf 'Published %s to %s/%s.\n' "$SITE_DIR" "$REMOTE" "$PUBLISH_BRANCH"
