#!/bin/sh

# zen-browser is the only browser you use, but keep chromium installed:
# omarchy-launch-webapp always shells out to chromium for --app mode,
# regardless of default browser. Zen/Firefox has no equivalent flag.
yay -R --noconfirm firefox
