#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SITE_LECTURES_DIR="$ROOT_DIR/_site/lectures"

if [[ ! -d "$SITE_LECTURES_DIR" ]]; then
  printf 'Missing %s. Run quarto render first.\n' "$SITE_LECTURES_DIR" >&2
  exit 1
fi

CHROME="${CHROME:-}"
if [[ -z "$CHROME" ]]; then
  for candidate in \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    "/Applications/Chromium.app/Contents/MacOS/Chromium" \
    "google-chrome" \
    "google-chrome-stable" \
    "chromium" \
    "chromium-browser"; do
    if command -v "$candidate" >/dev/null 2>&1 || [[ -x "$candidate" ]]; then
      CHROME="$candidate"
      break
    fi
  done
fi

if [[ -z "$CHROME" ]]; then
  printf 'No Chrome or Chromium executable found. Set CHROME=/path/to/chrome.\n' >&2
  exit 1
fi

for module in 01 02 03 04 05 06 07 08 09 10 11 12; do
  html="$SITE_LECTURES_DIR/module${module}.html"
  pdf="$SITE_LECTURES_DIR/module${module}.pdf"

  if [[ ! -f "$html" ]]; then
    printf 'Missing %s.\n' "$html" >&2
    exit 1
  fi

  "$CHROME" \
    --headless=new \
    --disable-gpu \
    --no-sandbox \
    --allow-file-access-from-files \
    --print-to-pdf="$pdf" \
    "file://$html?print-pdf" >/dev/null 2>&1

  printf 'Created %s\n' "$pdf"
done
