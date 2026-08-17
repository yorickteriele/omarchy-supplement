#!/bin/sh

# Not a daily browser (zen-browser is). Needed as the engine omarchy-launch-webapp
# always shells out to for --app mode; zen/Firefox has no equivalent flag.
yay -S --noconfirm --needed chromium
