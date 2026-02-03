;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(after! evil
  (defun my-send-str-to-terminal (str)
    (unless (display-graphic-p) (send-string-to-terminal str)))

  (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-str-to-terminal "\033[6 q")))
  (add-hook 'evil-insert-state-exit-hook (lambda () (my-send-str-to-terminal "\033[2 q"))))

(after! org
  (setq org-directory "~/.org/"
        org-agenda-files (list org-directory)
        org-ellipsis " ▼ "
        org-bullets-bullet-list '("#")))

(after! ledger-mode
  (setq ledger-binary-path "sledger"))

(after! js2-mode
  (add-hook 'js2-mode-local-vars-hook
            (lambda ()
              (when (flycheck-may-enable-checker 'javascript-eslint)
                (flycheck-select-checker 'javascript-eslint)))))

(defun lsp-ignore-node-files ()
  (seq-do #'(lambda (drct) (add-to-list 'lsp-file-watch-ignored-directories drct)) '("[/\\\\]\\out\\'" "[/\\\\]\\_next\\'" "[/\\\\]\\.next\\'" "[/\\\\]\\.husky\\'" "[/\\\\]\\.log\\'")))

(after! rjsx-mode
  (after! lsp-mode (lsp-ignore-node-files))
  (setq-hook! 'rjsx-mode-hook +format-with-lsp nil))

(after! typescript-mode
  (setq-hook! 'typescript-mode-hook +format-with-lsp nil)
  (setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)
  (setq lsp-clients-typescript-tls-path "/Users/osiris/.node_modules/bin/typescript-language-server")
  (after! lsp-mode (lsp-ignore-node-files)))

(setq package-install-upgrade-built-in t)

(after! rustic
  (setq rustic-format-on-save t)
  (setq-hook! 'rustic-mode-hook +format-with 'rustfmt))

(setq doom-font (font-spec :family "Fira Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Fira Sans")
      doom-big-font (font-spec :family "Fira Mono" :size 21)
      ;; theme
      doom-theme 'doom-vibrant
      projectile-project-search-path '("~/Work/")
      ;; relative line numbers by default
      display-line-numbers-type 'relative
      user-full-name "Enkh-Erdene Bolormaa"
      user-mail-address "enkhee.ag@gmail.com")

(map! :map +rust-keymap
      "TAB" #'company-indent-or-complete-common
      [tab] #'company-indent-or-complete-common)

(map! :localleader
      :map +rust-keymap
      (:prefix ("r" . "racer")
               "d" #'racer-find-definition
               "f" #'racer-find-definition-other-frame
               "w" #'racer-find-definition-other-window))

;; Fallback: open .astro in web-mode
(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))

;; ;; Prefer astro-ts-mode if available
(when (locate-library "astro-ts-mode")
  (add-to-list 'auto-mode-alist '("\\.astro\\'" . astro-ts-mode)))

(after! web-mode
  (setq web-mode-engines-alist
        '(("astro" . "\\.astro\\'")))

  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-script-padding 2
        web-mode-style-padding 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t
        web-mode-enable-current-element-highlight t))

;; Enhanced LSP setup for Astro
(after! lsp-mode
  ;; Add Astro language ID configurations
  (add-to-list 'lsp-language-id-configuration '(web-mode . "astro"))
  (add-to-list 'lsp-language-id-configuration '(astro-ts-mode . "astro"))

  (lsp-register-client
   (make-lsp-client
     :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
     :activation-fn (lsp-activate-on "astro")
     :server-id 'astro-ls
     :initialization-options
     (lambda ()
       (let ((project-root (projectile-project-root)))
         (when project-root
           `(:typescript (:tsdk ,(expand-file-name "node_modules/typescript/lib" project-root))))))
     :initialized-fn
     (lambda (workspace)
       ;; Tell server our config changed when buffer saves
       (with-lsp-workspace workspace
         (lsp--set-configuration
           `(:astro (:enable t :typescript (:tsdk ,(expand-file-name "node_modules/typescript/lib" (projectile-project-root))))))))
     :major-modes '(astro-ts-mode web-mode)))

  ;; Ignore additional Astro-related directories
  (lsp-ignore-node-files)
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.astro\\'"))

(after! tree-sitter
  (add-to-list 'tree-sitter-major-mode-language-alist '(astro-ts-mode . tsx))
  (add-to-list 'tree-sitter-major-mode-language-alist '(js-json-mode . json)))

;; Enhanced tree-sitter support
(setq treesit-language-source-alist
      '((astro "https://github.com/virchau13/tree-sitter-astro")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (jsdoc "https://github.com/tree-sitter/tree-sitter-jsdoc" "v0.23.2")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "v0.25.0")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))

;; Install grammars automatically
(mapc #'treesit-install-language-grammar '(astro css jsdoc json javascript typescript tsx))

;; Remap web-mode to astro-ts-mode where appropriate
(add-to-list 'major-mode-remap-alist '(web-mode . astro-ts-mode))

;; Enhanced Flycheck configuration for Astro
(after! flycheck
  (setq flycheck-disabled-checkers '(javascript-eslint javascript-jshint))

  ;; Use LSP for JavaScript/TypeScript linting
  (setq-hook! '(js-mode-hook js-jsx-mode-hook js2-mode-hook js2-jsx-mode-hook rjsx-mode-hook typescript-ts-mode-hook tsx-ts-mode-hook web-mode-hook astro-ts-mode-hook) flycheck-checker nil))

;; Ensure LSP provides diagnostics
(after! lsp-mode
  (setq lsp-diagnostics-provider :flycheck))

;; Astro-specific hooks and configurations
(defun my/setup-astro-mode ()
  "Setup configuration specific to Astro files."
  (when (and buffer-file-name (string-match "\\.astro\\'" buffer-file-name))
    ;; Enable LSP
    (lsp-deferred)
    ;; Set up proper indentation
    (setq-local tab-width 2)
    (setq-local indent-tabs-mode nil)))

;; Add hooks for both astro-ts-mode and web-mode when editing .astro files
(add-hook 'astro-ts-mode-hook #'my/setup-astro-mode)
(add-hook 'web-mode-hook
          (lambda ()
            (when (and buffer-file-name (string-match "\\.astro\\'" buffer-file-name))
              (my/setup-astro-mode))))

;; Enhanced keybindings for Astro development
(map! :after web-mode
      :map web-mode-map
      :localleader
      (:when (string-match "\\.astro\\'" (or buffer-file-name ""))
        (:prefix ("a" . "astro")
                 "f" #'format-all-buffer
                 "l" #'lsp-format-buffer
                 "r" #'lsp-rename
                 "d" #'lsp-find-definition
                 "i" #'lsp-organize-imports)))

(map! :after astro-ts-mode
      :map astro-ts-mode-map
      :localleader
      (:prefix ("a" . "astro")
               "f" #'format-all-buffer
               "l" #'lsp-format-buffer
               "r" #'lsp-rename
               "d" #'lsp-find-definition
               "i" #'lsp-organize-imports))

;;; END ENHANCED ASTRO CONFIGURATION ;;;

(after! typescript-ts-mode
  (add-hook 'typescript-ts-mode-hook
            (lambda ()
              (setq-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook js-ts-mode-hook) +format-with 'prettier)

              (setq flycheck-disabled-checkers nil)
              (setq-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook js-ts-mode-hook) flycheck-checker 'javascript-eslint))
            ))

;; Tailwindcss LSP (commented out as in original)
;; (use-package! lsp-tailwindcss)
;; (setq lsp-tailwindcss-major-modes '(rjsx-mode web-mode html-mode css-mode typescript-mode typescript-tsx-mode)
;;       lsp-tailwindcss-add-on-mode t)

;; Copilot configuration
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))
;;
;; (after! (evil copilot)
;;   ;; Define the custom function that either accepts the completion or does the default behavior
;;   (defun my/copilot-tab-or-default ()
;;     (interactive)
;;     (if (and (bound-and-true-p copilot-mode)
;;              ;; Add any other conditions to check for active copilot suggestions if necessary
;;              )
;;         (copilot-accept-completion)
;;       (evil-insert 1))) ; Default action to insert a tab. Adjust as needed.
;;
;;   ;; Bind the custom function to <tab> in Evil's insert state
;;   (evil-define-key 'insert 'global (kbd "<tab>") 'my/copilot-tab-or-default)
;;   (setq copilot-node-executable "/opt/homebrew/opt/node@20/bin/node")
;; )

;; Additional mode packages
;;(use-package! "bicep-mode" :load-path "/Users/osiris/.config/bicep-mode")
;;(use-package! "lsp-tailwindcss" :load-path "/Users/osiris/.config/lsp-tailwindcss")
;;(use-package! "prisma-mode" :load-path "/Users/osiris/.config/emacs-prisma-mode")
