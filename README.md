# Enkhee-Osiris’s Dotfiles

A collection of my personal dotfiles and development setup.

---

## Applications

Here is a list of applications I use regularly:

1. [Firefox](https://www.firefox.com/en-US/)
2. [Telegram](https://macos.telegram.org/)
3. [Warp](https://www.warp.dev/download)
4. [Ghostty](https://ghostty.org/download)
5. [Raycast](https://www.raycast.com/)
6. [Spotify](https://www.spotify.com/us/download/mac/)
7. [GPG Suite](https://gpgtools.org/)
8. [Xcode](https://developer.apple.com/download/all/?q=Xcode)

---

## Installation

### Prerequisites

- [Xcode Command Line Tools](http://railsapps.github.io/xcode-command-line-tools.html)

### Setup

Clone the repository and run the setup scripts:

```bash
git clone git@github.com:enkhee-osiris/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup/stuff.sh
./setup/zsh.sh
```

> ⚠️ `stuff.sh` installs general tools, and `zsh.sh` sets up Zsh with your preferred configuration.

---

## Scripts

```text
├──  setup
│   ├──  development.sh     # Installs development tools and utilities (Node, Python, Java)
│   ├──  emacs-exp.sh       # Sets up Native Emacs experimental configurations and packages
│   ├──  emacs.md           # Documentation for Emacs compile and setup
│   ├──  latex.sh           # Installs LaTeX
│   ├──  osx.sh             # Configures macOS settings and defaults
│   ├──  stuff.sh           # Installs general tools and apps I use regularly
│   └──  zsh.sh             # Sets up Zsh shell, plugins, and custom configurations
```

**Usage:**

Run scripts individually or in sequence depending on what you want to set up. For example:

```bash
# Install general tools
./setup/stuff.sh

# Set up your shell environment
./setup/zsh.sh

# Set up your development environment
./setup/development.sh
```

## Development Environment

I use [Doom Emacs](https://github.com/doomemacs/doomemacs) as my editor.

### Language Servers

Install my preferred language servers:

```bash
brew install texlab \
             marksman \
             yaml-language-server \
             pyright

npm install -g vscode-langservers-extracted \
               typescript-language-server \
               typescript \
               bash-language-server \
               @astrojs/language-server
```

### Formatters

I recommend installing project-specific formatters when possible. These are my general setup:

```bash
brew install black       # Python
npm install -g prettier  # JavaScript / TypeScript / HTML / CSS
```

---
