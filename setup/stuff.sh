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

# Extend global $PATH
echo -e "setenv PATH $HOME/dotfiles/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" | sudo tee /etc/launchd.conf

# Install source code pro font
brew tap caskroom/fonts && brew cask install font-source-code-pro

# Everything else
brew install ack
brew install the_silver_searcher
brew install gist
brew install exiftool
brew install zsh-syntax-highlighting
brew install fd
brew install fzf && $(brew --prefix)/opt/fzf/install
brew install diff-so-fancy

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
