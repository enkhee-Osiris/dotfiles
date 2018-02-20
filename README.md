[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](http://spacemacs.org)
# Enkhee-Osiris’s dotfiles

## Features

* Dotfiles synchronization: [sync.py](https://github.com/enkhee-osiris/dotfiles/blob/master/sync.py).
* Sensible macOS defaults: [setup/osx.sh](https://github.com/enkhee-osiris/dotfiles/blob/master/setup/osx.sh).
* Visual Studio Code settings synchronization: [vscode](https://github.com/enkhee-osiris/dotfiles/tree/master/vscode).
* zsh install script: [setup/zsh.sh](https://github.com/enkhee-osiris/dotfiles/blob/master/setup/zsh.sh).
* [zsh aliases](https://github.com/enkhee-osiris/dotfiles/blob/master/zsh/aliases.zsh).
* [Git aliases](https://github.com/enkhee-osiris/dotfiles/blob/master/tilde/gitconfig).

## Installation

Prerequisites:

1. [Install Xcode Command Line Tools](http://railsapps.github.io/xcode-command-line-tools.html).
1. [Generate SSH key](https://help.github.com/articles/generating-ssh-keys/).

Then run these commands in the terminal:

```
brew install git
git clone git@github.com:enkhee-osiris/dotfiles.git ~/dotfiles
cd ~/dotfiles
./sync
cd ~/dotfiles/setup
```

Now you can run scripts like below.
Take a look at [readme](https://github.com/enkhee-osiris/dotfiles/blob/master/setup/README.md)
```
./osx.sh
./stuff.sh
./spacemacs.sh
./tmux.sh
./zsh.sh
```


## Updating

```bash
dotfiles
```


## Resources

This project is inspired from [dotfiles](https://github.com/sapegin/dotfiles). And special thanks to [sapagin](https://github.com/sapegin).

* [GitHub ❤ ~/](http://dotfiles.github.io/)
* [Mathias’s dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Jan Moesen’s dotfiles](https://github.com/janmoesen/tilde)
* [Nicolas Gallagher’s dotfiles](https://github.com/necolas/dotfiles)
* [Zach Holman’s dotfiles](https://github.com/holman/dotfiles)
* [Yet Another Dotfile Repo](https://github.com/skwp/dotfiles)
* [Jacob Gillespie’s dotfiles](https://github.com/jacobwgillespie/dotfiles)


---
