#!/bin/bash

set -e

# Ask for the administrator password upfront
sudo -v

# Install Homebrew
command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with macOS are outdated)
brew install coreutils

# GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
brew install tree

# Git
brew install git
brew install git-delta

# Everything else
brew install fd
brew install ripgrep
brew install fzf
brew install eza
brew install bat
brew install vim

# Password store
brew install pass
brew install gnupg
brew install pass-otp

brew cleanup
