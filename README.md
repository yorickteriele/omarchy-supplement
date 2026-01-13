# omarchy-supplement

A small collection of helper scripts and configuration for setting up
applications, dotfiles, and development tools for use.

Repository structure

- `apps/` — installers and removers for desktop apps and utilities.
  - `installs/` — individual install scripts (e.g. `firefox.sh`, `gitkraken.sh`).
  - `removes/` — individual uninstall scripts.
- `dotfiles/` — (submodule) user configuration and helpers for dotfiles management.
- `neovim/` — (submodule) Neovim configuration and plugins.
- `webapps/` — scripts to install or uninstall web-oriented tools and services.
- `start.sh` — launcher script.

Submodules / nested repositories

- `dotfiles/` and `neovim/` are maintained as separate Git repositories. To initialize or update them from the
  repository root run:

```
git submodule update --init --recursive
```

 Run the included `start.sh` which performs the same steps and
attempts to update each sub-repository:

```
./start.sh
```

If you don't use submodules, you can update each folder directly, e.g.

```
git -C dotfiles pull
git -C neovim pull
```

Contributing

- Add new installers under `apps/installs/` and update `apps/install.sh` to call them.
- Provide matching remover scripts under `apps/removes/`.

License & Notes

- This repo is a personal utility collection. Review scripts before running, as
  they may perform system package installs and configuration changes.
