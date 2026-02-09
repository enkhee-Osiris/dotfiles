#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Emacs in Ghostty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📝
# @raycast.packageName Terminal Tools

# Documentation:
# @raycast.description Opens Ghostty and runs Emacs in terminal mode, then drops to Zsh.
# @raycast.author YourName

open -na Ghostty --args -e zsh -c "emacs -nw; exec zsh"
