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

### Spotify

Installs spicetify

### Tmux

Install tmux with plugins

### update

Get macOS software updates, update Homebrew, npm, Ruby packages, dotfiles and some other software.

## Tips & Tricks

### Emacs config setip

```
curl -fsSL https://gist.github.com/enkhee-Osiris/00ceb922eb3ff82d3ec13bca6b3af664 -o ~/.spacemacs
```

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

### Installing tmux plugins

As usual, plugins need to be specified in `.tmux.conf`. Run the following
command to install plugins:

    ~/.tmux/plugins/tpm/bin/install_plugins

### Updating tmux plugins

To update all installed plugins:

    ~/.tmux/plugins/tpm/bin/update_plugins all

or update a single plugin:

    ~/.tmux/plugins/tpm/bin/update_plugins tmux-sensible

### Removing tmux plugins

To remove plugins not on the plugin list:

    ~/.tmux/plugins/tpm/bin/clean_plugins


## Misc

* [OSX Python developer guide](https://gist.github.com/stefanfoulis/902296)
