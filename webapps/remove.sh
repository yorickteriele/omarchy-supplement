#!/usr/bin/env bash

DEFAULT_WEBAPPS=(
  "HEY"
  "Basecamp"
  "Google Photos"
  "Google Contacts"
  "Google Messages"
  "YouTube"
  "GitHub"
  "X"
  "Figma"
  "Zoom"
  "Fizzy"
)

for app in "${DEFAULT_WEBAPPS[@]}"; do
  echo "Removing $app"
  omarchy-webapp-remove "$app"
done

