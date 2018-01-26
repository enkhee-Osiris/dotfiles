#!/bin/bash

mv ~/.emacs.d ~/.emacs.d.bak
mv ~/.emacs ~/.emacs.bak

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

curl -fsSL https://gist.githubusercontent.com/enkhee-Osiris/a9cbf027b587f4d2a0faa8b7a5129c65/raw/73938eb6c4290a51afcb54bf1cb7663a1e95501f/init.el -o ~/.emacs.d/init.el
