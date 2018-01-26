#!/bin/bash

mv ~/.emacs.d ~/.emacs.d.bak
mv ~/.emacs ~/.emacs.bak

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

