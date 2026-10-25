#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ./plugins.sh

for id in "${!PLUGINS[@]}"; do
  echo "Removing plugin: $id"
  omarchy plugin remove "$id" --yes
done

for dir in ./local/*/; do
  [ -d "$dir" ] || continue
  id=$(basename "$dir")
  target="$HOME/.config/omarchy/plugins/$id"
  [ -L "$target" ] || continue
  echo "Removing local plugin: $id"
  omarchy plugin disable "$id" 2>/dev/null || true
  rm "$target"
done
