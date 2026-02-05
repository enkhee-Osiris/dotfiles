#!/usr/bin/env bash

set -e

# Ensure Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Aborting."
  exit 1
fi

# ------------------------------------------------------------------------------
# Versions
# ------------------------------------------------------------------------------

PYTHON_VERSION="3.14"
NODE_VERSION="22"
JAVA_VERSION="17"

# ------------------------------------------------------------------------------
# Privilege escalation (only if needed)
# ------------------------------------------------------------------------------

if [[ $EUID -ne 0 ]]; then
  sudo -v
fi

# ------------------------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------------------------

brew update
brew upgrade

HOMEBREW_PREFIX="$(brew --prefix)"

# ------------------------------------------------------------------------------
# Python
# ------------------------------------------------------------------------------

brew install "python@${PYTHON_VERSION}"

PYTHON_BIN="$HOMEBREW_PREFIX/opt/python@${PYTHON_VERSION}/libexec/bin/python${PYTHON_VERSION}"

"$PYTHON_BIN" -m ensurepip --upgrade
"$PYTHON_BIN" -m pip install --upgrade pip setuptools

# Optional system-wide python symlink
sudo ln -sfn "$PYTHON_BIN" /usr/local/bin/python

# ------------------------------------------------------------------------------
# Node.js
# ------------------------------------------------------------------------------

brew install "node@${NODE_VERSION}"

NODE_BIN="$HOMEBREW_PREFIX/opt/node@${NODE_VERSION}/bin"

# User-level global npm packages
export NPM_PACKAGES="$HOME/.node_modules"
mkdir -p "$NPM_PACKAGES"

"$NODE_BIN/npm" install -g npm

# ------------------------------------------------------------------------------
# Ruby
# ------------------------------------------------------------------------------

brew install ruby

RUBY_BIN="$HOMEBREW_PREFIX/opt/ruby/bin"

"$RUBY_BIN/gem" install cocoapods

# ------------------------------------------------------------------------------
# Java
# ------------------------------------------------------------------------------

brew install "openjdk@${JAVA_VERSION}"

sudo ln -sfn \
  "$HOMEBREW_PREFIX/opt/openjdk@${JAVA_VERSION}/libexec/openjdk.jdk" \
  "/Library/Java/JavaVirtualMachines/openjdk-${JAVA_VERSION}.jdk"

# ------------------------------------------------------------------------------
# Cleanup
# ------------------------------------------------------------------------------

brew cleanup
