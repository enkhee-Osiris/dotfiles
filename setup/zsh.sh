#!/usr/bin/env bash

set -e

# Ask for the administrator password upfront
if [[ $EUID -ne 0 ]]; then
  sudo -v
fi

# Install zsh via Homebrew if needed
if ! command -v zsh >/dev/null 2>&1; then
  brew install zsh
fi

brew cleanup

# Ensure zsh is listed in /etc/shells
zsh_path="$(command -v zsh)"
if ! grep -Fxq "$zsh_path" /etc/shells; then
  echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
fi

# Change default shell to zsh
chsh -s "$zsh_path" "$USER"

# Install Oh My Zsh (non-interactive)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Powerlevel10k theme
if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  git clone --depth=1 \
    https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Plugins
declare -A plugins=(
  [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions"
  [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  [zsh-eza]="https://github.com/z-shell/zsh-eza.git"
)

for plugin in "${!plugins[@]}"; do
  if [[ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]]; then
    git clone "${plugins[$plugin]}" "$ZSH_CUSTOM/plugins/$plugin"
  fi
done
