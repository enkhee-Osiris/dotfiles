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

;;; ENHANCED ASTRO CONFIGURATION ;;;

;; Astro file association - improved fallback handling
(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))

;; Override with astro-ts-mode if available
(when (locate-library "astro-ts-mode")
  (add-to-list 'auto-mode-alist '("\\.astro\\'" . astro-ts-mode)))

;; Enhanced web-mode configuration for Astro
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

  ;; Enhanced Astro LSP client with TypeScript SDK support
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
    :major-modes '(astro-ts-mode web-mode)))

  ;; Ignore additional Astro-related directories
  (lsp-ignore-node-files)
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.astro\\'"))

;; Enhanced tree-sitter support
(after! tree-sitter
  (add-to-list 'tree-sitter-major-mode-language-alist '(astro-ts-mode . tsx)))

;; Enhanced Flycheck configuration for Astro
(after! flycheck
  ;; Enable ESLint for various modes including Astro
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'astro-ts-mode)
  (flycheck-add-mode 'javascript-eslint 'typescript-mode)
  (flycheck-add-mode 'javascript-eslint 'js-mode)
  (flycheck-add-mode 'typescript-tslint 'astro-ts-mode)

  ;; Increase error threshold for larger projects
  (setq flycheck-checker-error-threshold 2000)
  (setq flycheck-eslint-rules-directories '("node_modules")))

;; Enhanced format-all configuration for Astro with Prettier+ESLint
(after! format-all
  ;; Remove the old simple prettier formatter for Astro
  (setq format-all-formatters
        (assoc-delete-all "Astro" format-all-formatters))

  ;; Add enhanced prettier-eslint formatter for Astro
  (add-to-list 'format-all-formatters
               '("Astro" (prettier-eslint
                          (lambda (executable mode-result)
                            (when (executable-find "npx")
                              (list "npx" "eslint" "--stdin" "--fix-dry-run" "--format=json" "--stdin-filename" (buffer-file-name)))))))

  ;; Set format-on-save for Astro files
  (setq +format-on-save-enabled-modes
        '(not emacs-lisp-mode sql-mode tex-mode latex-mode org-msg-edit-mode))

  ;; Enable format-all-mode for web development modes
  (add-hook! (web-mode astro-ts-mode typescript-mode js-mode)
    (format-all-mode 1)))

;; Astro-specific hooks and configurations
(defun my/setup-astro-mode ()
  "Setup configuration specific to Astro files."
  (when (and buffer-file-name (string-match "\\.astro\\'" buffer-file-name))
    ;; Enable LSP
    (lsp-deferred)
    ;; Set up proper indentation
    (setq-local tab-width 2)
    (setq-local indent-tabs-mode nil)
    ;; Enable format on save
    (add-hook 'before-save-hook 'format-all-buffer nil t)))

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

;; Auto-format imports and fix ESLint issues on save
(defun my/eslint-fix-and-format ()
  "Fix ESLint issues and format buffer."
  (when (and buffer-file-name
             (or (eq major-mode 'web-mode)
                 (eq major-mode 'astro-ts-mode)
                 (eq major-mode 'typescript-mode)
                 (eq major-mode 'js-mode))
             (string-match "\\.(astro\\|ts\\|js\\|tsx\\|jsx)\\'" buffer-file-name)
             (executable-find "npx"))
    (let ((current-point (point)))
      (shell-command (concat "npx eslint --fix " (shell-quote-argument buffer-file-name)))
      (revert-buffer t t t)
      (goto-char current-point))))

;; Optional: Enable auto-fix on save (uncomment if desired)
;; (add-hook 'before-save-hook #'my/eslint-fix-and-format)

;;; END ENHANCED ASTRO CONFIGURATION ;;;

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
