#!/usr/bin/env bash

set -e

# Ensure Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Aborting."
  exit 1
fi

# Update Homebrew
brew update
brew upgrade

brew install --cask mactex-no-gui

eval "$(/usr/libexec/path_helper)"

brew cleanup
