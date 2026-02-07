#!/usr/bin/env bash
# macOS Tahoe Setup Script
# Upgrades system defaults, UI/UX, Finder, Dock, keyboard, and power settings
# Safe and modular with logging

set -euo pipefail

###############################
# Helpers
###############################

log() { echo -e "\033[1;34m[INFO]\033[0m $*"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $*"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

ask_sudo() {
  log "Requesting sudo access..."
  sudo -v
  # Keep sudo alive
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

###############################
# Computer Identity
###############################

COMPUTERNAME='macbook'
LOCALHOSTNAME='macbook'

set_computer_name() {
  log "Setting computer name to $COMPUTERNAME..."
  sudo scutil --set ComputerName "$COMPUTERNAME"
  sudo scutil --set HostName "$COMPUTERNAME"
  sudo scutil --set LocalHostName "$LOCALHOSTNAME"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$LOCALHOSTNAME"
}

###############################
# UI/UX Tweaks
###############################

configure_ui() {
  log "Configuring general UI/UX..."
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
  defaults write NSGlobalDomain LSQuarantine -bool false
  defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
  defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
  defaults write com.apple.CrashReporter DialogType -string "none"
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
  defaults write -g AppleAquaColorVariant -int 6
}

###############################
# Keyboard & Input
###############################

configure_keyboard() {
  log "Configuring keyboard..."
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 10
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
  echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
  sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled
}

###############################
# Finder & Dock
###############################

configure_finder_dock() {
  log "Configuring Finder and Dock..."

  # Finder
  defaults write com.apple.finder AppleShowAllFiles -bool true
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder QLEnableTextSelection -bool true
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

  # Dock
  defaults write com.apple.dock tilesize -int 40
  defaults write com.apple.dock autohide -bool false
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.dock autohide-time-modifier -float 0
  defaults write com.apple.dock launchanim -bool false
  defaults write com.apple.dock expose-animation-duration -float 0.1
  defaults write com.apple.dock no-bouncing -bool true
  defaults write com.apple.dock workspaces-auto-swoosh -bool true
  defaults write com.apple.dock static-only -bool true
}

###############################
# Screen, Screenshots & Display
###############################

configure_display() {
  log "Configuring screen, display, and screenshots..."
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screencapture location -string "$HOME/Desktop"
  defaults write com.apple.screencapture type -string "png"
  defaults write NSGlobalDomain AppleFontSmoothing -int 2
  sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
}

###############################
# Power & Sleep
###############################

configure_power() {
  log "Configuring power settings..."

  # Battery
  sudo pmset -b sleep 10
  sudo pmset -b displaysleep 5
  sudo pmset -b disksleep 10
  sudo pmset -b lessbright 1
  sudo pmset -b halfdim 1

  # Power Adapter
  sudo pmset -c sleep 30
  sudo pmset -c displaysleep 10
  sudo pmset -c disksleep 10
  sudo pmset -c womp 0
  sudo pmset -c halfdim 1
  sudo pmset -c autorestart 1
}

###############################
# Cleanup / Restart affected apps
###############################

restart_apps() {
  log "Restarting affected applications..."
  for app in "Dock" "Finder" "Mail" "Safari" "SystemUIServer" "Terminal"; do
    killall "$app" > /dev/null 2>&1 || true
  done
}

###############################
# Main
###############################

main() {
  ask_sudo
  set_computer_name
  configure_ui
  configure_keyboard
  configure_finder_dock
  configure_display
  configure_power
  restart_apps
  log "Setup complete! Some changes require logout/restart to take full effect."
}

main
