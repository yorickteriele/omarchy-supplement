#!/bin/sh

echo "Temp -> Nothing to remove"

for file in apps/removes/*; do
  if [ -x "$file" ] && [ ! -d "$file" ]; then
    echo "Removing: $file"
    "$file"
  else
    echo "Not an executable $file"
  fi
done
