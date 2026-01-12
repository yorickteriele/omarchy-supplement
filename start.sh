#!/bin/sh

echo "Starting Installation"

for file in installs/*; do
  if [ -x "$file" ] && [ ! -d "$file" ]; then
    echo "$file"
    "$file"
  else
    echo "Not an executable $file"
  fi
done

