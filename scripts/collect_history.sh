#!/usr/bin/env bash
set -euo pipefail

list_file="${1:-}"
out_dir="${2:-data}"

if [ -z "$list_file" ]; then
  echo "Usage: $0 LIST_FILE [OUTPUT_DIR]" >&2
  exit 2
fi

if [ ! -f "$list_file" ]; then
  echo "List file not found: $list_file" >&2
  exit 2
fi

mkdir -p "$out_dir"

while IFS= read -r word || [ -n "$word" ]; do
  [ -z "$word" ] && continue

  echo "[run] ${word}"

  if python src/extract_viewer_history.py "$word" --csv "${out_dir}/${word}.csv"; then
    echo "[ok] ${word}"
  else
    echo "[ng] ${word}" >&2
    printf '%s\n' "$word" >> "${out_dir}/errors.txt"
  fi

  sleep 2
done < "$list_file"
