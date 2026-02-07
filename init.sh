#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles/tilde"
TARGET_DIR="$HOME"

# ---------------------------
# Backups
# ---------------------------
[ -e "$TARGET_DIR/.gitconfig" ] && mv -f "$TARGET_DIR/.gitconfig" "$TARGET_DIR/.gitconfig.backup"
[ -e "$TARGET_DIR/.gitignore" ] && mv -f "$TARGET_DIR/.gitignore" "$TARGET_DIR/.gitignore.backup"
[ -e "$TARGET_DIR/.p10k.zsh" ] && mv -f "$TARGET_DIR/.p10k.zsh" "$TARGET_DIR/.p10k.zsh.backup"
[ -e "$TARGET_DIR/.ripgreprc" ] && mv -f "$TARGET_DIR/.ripgreprc" "$TARGET_DIR/.ripgreprc.backup"
[ -e "$TARGET_DIR/.vimrc" ] && mv -f "$TARGET_DIR/.vimrc" "$TARGET_DIR/.vimrc.backup"
[ -e "$TARGET_DIR/.zprofile" ] && mv -f "$TARGET_DIR/.zprofile" "$TARGET_DIR/.zprofile.backup"
[ -e "$TARGET_DIR/.zshrc" ] && mv -f "$TARGET_DIR/.zshrc" "$TARGET_DIR/.zshrc.backup"
[ -e "$TARGET_DIR/.config" ] && mv -f "$TARGET_DIR/.config" "$TARGET_DIR/.config.backup"
[ -e "$TARGET_DIR/.org" ] && mv -f "$TARGET_DIR/.org" "$TARGET_DIR/.org.backup"

# ---------------------------
# Symlinks
# ---------------------------
ln -sf "$DOTFILES_DIR/gitconfig"   "$TARGET_DIR/.gitconfig"
ln -sf "$DOTFILES_DIR/gitignore"   "$TARGET_DIR/.gitignore"
ln -sf "$DOTFILES_DIR/p10k.zsh"    "$TARGET_DIR/.p10k.zsh"
ln -sf "$DOTFILES_DIR/ripgreprc"   "$TARGET_DIR/.ripgreprc"
ln -sf "$DOTFILES_DIR/vimrc"       "$TARGET_DIR/.vimrc"
ln -sf "$DOTFILES_DIR/zprofile"    "$TARGET_DIR/.zprofile"
ln -sf "$DOTFILES_DIR/zshrc"       "$TARGET_DIR/.zshrc"
ln -sf "$DOTFILES_DIR/config"      "$TARGET_DIR/.config"
ln -sf "$DOTFILES_DIR/org"         "$TARGET_DIR/.org"

echo "All symlinks created. Previous files backed up with .backup suffix."
