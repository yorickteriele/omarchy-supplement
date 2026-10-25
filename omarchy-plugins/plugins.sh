#!/usr/bin/env bash

# id -> git url for all omarchy-shell plugins installed on this machine.
#
# yorick.workspaces is a local `omarchy plugin clone` of the built-in
# omarchy.workspaces plugin (no upstream remote) — not listed here since
# there's nothing to fetch; it lives only in ~/.config/omarchy/plugins.
declare -A PLUGINS=(
  [emilsall.spotify-wallpaper]="https://github.com/emilsall/omarchy-spotify-wallpaper.git"
  [io.github.sirjul1337.lock-explorer]="https://github.com/SirJul1337/omarchy-lock-explorer.git"
  [io.github.thisisgm.omapods]="https://github.com/thisisgm/omarchy-pods.git"
  [io.github.tyrichards.tray]="https://github.com/TyRichards/omarchy-tray.git"
  [jankeesvw.notification-center]="https://github.com/jankeesvw/omarchy-notification-center.git"
  [mandavkarpranjal.cam-preview]="https://github.com/mandavkarpranjal/cam-preview.git"
  [omaplug]="https://github.com/fross100/omaplug.git"
  [quickshell.spotify]="https://github.com/stappmus/Omarchy-Spotify.git"
)
