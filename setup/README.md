## Prerequisites

* [Command Line Tools for Xcode](https://developer.apple.com/downloads)

## Scripts

### stuff

Installs Homebrew, Git, [git-extras](https://github.com/tj/git-extras), Node, pip, etc.

### zsh

Installs zsh and Oh My Zsh, registers zsh as the default shell.

### osx

Sane OSX defaults. Based on [~/.osx](https://github.com/mathiasbynens/dotfiles/blob/master/.macos) by @mathiasbynens.

### quicklook

Installs quick look plugins: qlImageSize.

### spacemacs

Installs spacemacs.

### Tmux

Install tmux with plugins

### update

Get macOS software updates, update Homebrew, npm, Ruby packages, dotfiles and some other software.

## Tips & Tricks

### Local Git identity

```
git config -f ~/.gitlocal user.email "enkhee.ag@gmail.com"
git config -f ~/.gitlocal user.name "enkhee-Osiris"
```

### Per repository Git identity

```
cd ~/repo
git config user.email "enkhee.ag@gmail.com"
git config user.name "enkhee-Osiris"
```

## Misc

* [OSX Python developer guide](https://gist.github.com/stefanfoulis/902296)