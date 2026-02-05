;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font")
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 21)
      ;;
      ;;
      ;; theme
      doom-theme 'modus-vivendi
      projectile-project-search-path '("~/Work/")
      ;;
      ;;
      ;; relative line numbers by default
      display-line-numbers-type 'relative
      ;;
      ;;
      ;; user infos
      user-full-name "Enkh-Erdene Bolormaa"
      user-mail-address "enkhee.ag@gmail.com"
      ;;
      ;;
      ;;
      org-directory "~/.org/")
