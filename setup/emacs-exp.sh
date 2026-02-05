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

# Dependencies for Emacs (native-comp + tree-sitter + SVG)
brew install \
  gcc \
  automake \
  gnutls \
  pkg-config \
  texinfo \
  librsvg \
  libxml2 \
  tree-sitter

# Tap emacs-mac experimental port if needed
if ! brew tap | grep -q '^pkryger/emacsmacport-exp$'; then
  brew tap pkryger/emacsmacport-exp
fi

# Install Emacs Mac port (HEAD)
brew install --HEAD emacs-mac-exp \
  --with-optimization-flags \
  --with-transparent-titlebar \
  --with-arc \
  --with-no-title-bars \
  --with-unlimited-select \
  --with-tree-sitter \
  --with-modules

# Create a wrapper Emacs.app in /Applications (optional)
EMACS_APP="$(brew --prefix)/opt/emacs-mac-exp@30/Emacs.app"

osacompile -o "/Applications/Emacs.app" \
  -e "tell application \"Finder\" to open POSIX file \"$EMACS_APP\""

brew cleanup
