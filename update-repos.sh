#!/bin/bash
repos=(
  "dotfiles-https://github.com/yorickteriele/dotfiles.git"
  "dotfiles/neovim-https://github.com/yorickteriele/neovim.git"
)

for repo_info in "${repos[@]}"; do
  path="${repo_info%%-*}"
  url="${repo_info##*-}"
  
  if [ -d "$path/.git" ]; then
    echo "Updating $path..."
    git -C "$path" pull
  else
    echo "Cloning $path..."
    git clone "$url" "$path"
  fi
done
