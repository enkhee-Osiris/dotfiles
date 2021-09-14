#!/usr/bin/env bash

set -e

abs_path () {
  local result_path=""

  pushd "$(dirname "${1}")" > /dev/null

  result_path=$(pwd -L)

  popd > /dev/null

  echo "${result_path}"
}

# Require Homebrew
command -v brew >/dev/null 2>&1 || { echo >&2 "Please install Homebrew first."; exit 1; }

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

CURRENT_SCRIPT_PATH="$(abs_path "${0}")"

DOTFILES_PATH="$(dirname "${CURRENT_SCRIPT_PATH}")"

THEME_PATH="${DOTFILES_PATH}/spicetify_sleek"

if ! command -v spicetify &> /dev/null; then
  # Make sure we’re using the latest Homebrew
  brew update

  brew install khanhas/tap/spicetify-cli
fi

if [[ ! -d "${HOME}/spicetify_data/Backup" ]]; then
  spicetify
  spicetify backup apply enable-devtool
fi

spicetify config custom_apps lyrics-plus
spicetify config extensions keyboardShortcut.js

if [[ ! -d "${HOME}/spicetify_data/Themes/Sleek" ]]; then
  ln -fs "${THEME_PATH}" "${HOME}/spicetify_data/Themes/Sleek"

  spicetify config current_theme Sleek
  spicetify config color_scheme UltraBlack
fi

spicetify apply
