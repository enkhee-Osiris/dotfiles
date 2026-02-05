#!/bin/bash

set -e

# Ask for the administrator password upfront
sudo -v

# Install dependencies
brew install gcc
brew install libgccjit
brew install automake
brew install gnutls
brew install pkg-config
brew install texinfo
brew install librsvg
brew install libxml2
brew install tree-sitter

brew tap pkryger/emacsmacport-exp
brew install --HEAD emacs-mac-exp --with-optimization-flags --with-transparent-titlebar --with-arc --with-no-title-bars --with-unlimited-select --with-tree-sitter --with-modules

osacompile -o Emacs.app -e 'tell application "Finder" to open POSIX file "'"$(brew --prefix)"'/opt/emacs-mac-exp@30/Emacs.app"'

brew cleanup
