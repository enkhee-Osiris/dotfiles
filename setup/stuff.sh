#!/usr/bin/env bash

set -e

# Ask for the administrator password upfront
if [[ $EUID -ne 0 ]]; then
  sudo -v
fi

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew and installed formulae
brew update
brew upgrade

# Core utilities
brew install \
  coreutils \
  findutils \
  tree

# Git
brew install \
  git \
  git-delta

# CLI tools
brew install \
  fd \
  ripgrep \
  fzf \
  eza \
  bat \
  vim

# Password management
brew install \
  pass \
  gnupg \
  pass-otp

brew cleanup
