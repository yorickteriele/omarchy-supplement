#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ./plugins.sh

# "omarchy plugin add" is safe to re-run: it exits non-zero and leaves the
# existing install alone if the id is already used.
for id in "${!PLUGINS[@]}"; do
  echo "Adding plugin: $id"
  omarchy plugin add "${PLUGINS[$id]}" --enable --yes
done

# Plugins authored here, with no upstream git remote: symlink each folder
# under local/ into the live plugins dir and enable it.
for dir in ./local/*/; do
  [ -d "$dir" ] || continue
  id=$(basename "$dir")
  target="$HOME/.config/omarchy/plugins/$id"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Skipping local plugin $id: $target already exists and isn't a symlink"
    continue
  fi
  echo "Linking local plugin: $id"
  ln -sfn "$(cd "$dir" && pwd)" "$target"
  omarchy-shell shell rescanPlugins >/dev/null 2>&1 || true
  omarchy plugin enable "$id"
done
