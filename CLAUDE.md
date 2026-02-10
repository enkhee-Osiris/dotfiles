# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS (Apple Silicon). Configs are stored in `tilde/` and symlinked to `$HOME` via `init.sh`. This is **not** GNU Stow — symlinks are manual `ln -sf` commands.

## Setup Commands

```bash
./init.sh                  # Symlink all configs to $HOME (backs up existing files as .backup)
./setup/stuff.sh           # Core CLI tools via Homebrew
./setup/zsh.sh             # Oh My Zsh + Powerlevel10k + plugins
./setup/development.sh     # Python 3.12, Node 22, Java 17, Ruby
./setup/osx.sh             # macOS system defaults
./setup/latex.sh           # MacTeX
./setup/emacs-exp.sh       # Experimental Emacs Mac port build
```

## Architecture

**Symlink mapping** (`init.sh`): Files in `tilde/` map directly to `$HOME`. For example, `tilde/.gitconfig` → `~/.gitconfig`, `tilde/config/` → `~/.config/`.

**Key config locations:**
- `tilde/.zshrc` / `tilde/.zprofile` — Zsh config and PATH/environment setup
- `tilde/.gitconfig` — Git aliases, delta pager, color scheme
- `tilde/config/doom/` — Doom Emacs user config (init.el, config.el, packages.el)
- `tilde/config/ghostty/` — Ghostty terminal config
- `tilde/config/raycast/` — Raycast scripts and extensions

**Doom Emacs** is the primary editor. Config uses evil mode, eglot for LSP, tree-sitter, corfu/vertico for completion. Languages: JS/TS, Python, LaTeX, Markdown, YAML, Bash, Astro.

## Conventions

- 2-space indentation, UTF-8, LF line endings (see `.editorconfig`)
- Setup scripts are independent and idempotent — run individually as needed
- Only `doom/`, `raycast/`, and `ghostty/` configs are git-tracked under `tilde/config/` (the rest is gitignored)
