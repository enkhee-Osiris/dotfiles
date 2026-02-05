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

PYTHON_VERSION="3.12"
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

if [[ ! -d "$HOMEBREW_PREFIX/opt/python@${PYTHON_VERSION}" ]]; then
  brew install "python@${PYTHON_VERSION}"
fi

PYTHON_BIN="$HOMEBREW_PREFIX/opt/python@${PYTHON_VERSION}/libexec/bin/python${PYTHON_VERSION}"

if [[ -x "$PYTHON_BIN" ]]; then
  "$PYTHON_BIN" -m ensurepip --upgrade
  "$PYTHON_BIN" -m pip install --upgrade pip setuptools

  if [[ -d /usr/local/bin ]]; then
    sudo ln -sfn "$PYTHON_BIN" /usr/local/bin/python
  fi
fi

# ------------------------------------------------------------------------------
# Node.js
# ------------------------------------------------------------------------------

if [[ ! -d "$HOMEBREW_PREFIX/opt/node@${NODE_VERSION}" ]]; then
  brew install "node@${NODE_VERSION}"
fi

NODE_BIN="$HOMEBREW_PREFIX/opt/node@${NODE_VERSION}/bin"

if [[ -x "$NODE_BIN/npm" ]]; then
  export NPM_PACKAGES="$HOME/.node_modules"
  mkdir -p "$NPM_PACKAGES"

  "$NODE_BIN/npm" install -g npm
fi

# ------------------------------------------------------------------------------
# Ruby
# ------------------------------------------------------------------------------

if [[ ! -d "$HOMEBREW_PREFIX/opt/ruby" ]]; then
  brew install ruby
fi

RUBY_GEM="$HOMEBREW_PREFIX/opt/ruby/bin/gem"

if [[ -x "$RUBY_GEM" ]]; then
  "$RUBY_GEM" install cocoapods
fi

# ------------------------------------------------------------------------------
# Java
# ------------------------------------------------------------------------------

if [[ ! -d "$HOMEBREW_PREFIX/opt/openjdk@${JAVA_VERSION}" ]]; then
  brew install "openjdk@${JAVA_VERSION}"
fi

JDK_SOURCE="$HOMEBREW_PREFIX/opt/openjdk@${JAVA_VERSION}/libexec/openjdk.jdk"
JDK_TARGET="/Library/Java/JavaVirtualMachines/openjdk-${JAVA_VERSION}.jdk"

if [[ -d "$JDK_SOURCE" ]]; then
  sudo ln -sfn "$JDK_SOURCE" "$JDK_TARGET"
fi

# ------------------------------------------------------------------------------
# Cleanup
# ------------------------------------------------------------------------------

brew cleanup
