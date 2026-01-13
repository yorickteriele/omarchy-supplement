#!/bin/sh

for file in apps/installs/*; do
  if [ -x "$file" ] && [ ! -d "$file" ]; then
    echo "$file"
    "$file"
  else
    echo "Not an executable $file"
  fi
done
