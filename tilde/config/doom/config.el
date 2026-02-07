;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


(setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font Mono" :size 13 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font Mono" :size 13)
      doom-big-font (font-spec :family "JetBrainsMonoNL Nerd Font Mono" :size 28 :weight 'regular)
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

;;; Customization

(defun my-weebery-is-always-greater ()
  (let* ((banner '("⢸⣿⣿⣿⣿⠃⠄⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀⠄"
                   "⢸⣿⣿⣿⡟⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷"
                   "⢸⣿⣿⠟⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿"
                   "⢸⣿⢫⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿"
                   "⡿⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿"
                   "⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿"
                   "⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟"
                   "⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣"
                   "⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾"
                   "⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿"
                   "⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿"
                   "⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿"
                   "⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿"
                   "⠄⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋⠄⠄⣾⡌⢠⣿⡿⠃"
                   "⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉⠄⠄          "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)
;;; END Customization

(after! treesit
  (add-to-list 'treesit-language-source-alist
               '(bash "https://github.com/tree-sitter/tree-sitter-bash"
                 "master"
                 "src")))

;;; Astro / Tree-sitter / Eglot setup

;; -------------------------
;; Astro major mode
;; -------------------------
(use-package! astro-ts-mode
  :config
  (set-tree-sitter! 'astro-mode 'astro-ts-mode
    '((astro :url "https://github.com/virchau13/tree-sitter-astro"))))

(add-to-list 'auto-mode-alist '("\\.astro\\'" . astro-ts-mode))

(add-hook! astro-ts-mode
  (setq-local
   astro-ts-mode-indent-offset 2
   comment-start "<!-- "
   comment-end " -->"))

;; -------------------------
;; Eglot (Astro language server)
;; -------------------------
(after! eglot
  (add-to-list
   'eglot-server-programs
   `(astro-ts-mode
     . ("astro-ls" "--stdio"
        :initializationOptions
        (:typescript
         (:tsdk ,(expand-file-name
                  "node_modules/typescript/lib"
                  (doom-project-root))))))))

(add-hook 'astro-ts-mode-hook #'eglot-ensure)


;; -------------------------
;; Formatting (Prettier)
;; -------------------------
(set-formatter! 'prettier-astro
  '("npx" "prettier" "--parser=astro")
  :modes '(astro-ts-mode))
;;; END OF Astro / Tree-sitter / Eglot setup
