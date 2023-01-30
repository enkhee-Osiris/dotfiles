#!/bin/bash

set -e

# Installs Homebrew, Git, git-extras, Node.js, python etc.

# Ask for the administrator password upfront
sudo -v

# Install Homebrew
command -v brew >/dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# GNU core utilities (those that come with macOS are outdated)
brew install coreutils

# GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
brew install tree

# More recent versions of some macOS tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Git
brew install git
brew install git-extras
brew install git-delta

# Extend global $PATH
echo -e "setenv PATH $HOME/dotfiles/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" | sudo tee /etc/launchd.conf

# Install source code pro font
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-fira-sans
brew install --cask font-dejavu

# Everything else
brew install ack
brew install the_silver_searcher
brew install gist
brew install exiftool
brew install fd
brew install ripgrep
brew install fzf && $(brew --prefix)/opt/fzf/install

# Node
brew install node
npm config set loglevel warn

# Npm
npm i -g npm-upgrade
npm i -g trash-cli
npm i -g tern

# Python
brew install python

# Emacs install with brew
brew tap d12frosted/emacs-plus
brew install emacs-plus
ln -s /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/

# Remove outdated versions from the cellar
brew cleanup
