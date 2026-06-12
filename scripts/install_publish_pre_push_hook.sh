#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOK_PATH="$ROOT_DIR/.git/hooks/pre-push"

if [[ ! -d "$ROOT_DIR/.git" ]]; then
  printf 'This script must be run from a Git checkout with a .git directory.\n' >&2
  exit 1
fi

if [[ -f "$HOOK_PATH" ]]; then
  backup="$HOOK_PATH.backup.$(date +%Y%m%d%H%M%S)"
  cp "$HOOK_PATH" "$backup"
  printf 'Backed up existing pre-push hook to %s\n' "$backup"
fi

cat > "$HOOK_PATH" <<'HOOK'
#!/usr/bin/env bash
set -euo pipefail

if [[ "${COMP331_SKIP_PUBLISH_HOOK:-}" == "1" ]]; then
  exit 0
fi

remote_name="$1"
should_publish=0

while read -r local_ref _local_sha _remote_ref _remote_sha; do
  if [[ "$local_ref" == "refs/heads/main" ]]; then
    should_publish=1
  fi
done

if [[ "$should_publish" == "1" ]]; then
  COMP331_SKIP_PUBLISH_HOOK=1 bash scripts/publish_gh_pages.sh "$remote_name"
fi
HOOK

chmod +x "$HOOK_PATH"
printf 'Installed local pre-push hook at %s\n' "$HOOK_PATH"
