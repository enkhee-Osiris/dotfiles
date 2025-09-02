;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; (package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
;; (package! copilot :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))

;; For TypeScript/JavaScript support (likely already enabled)
(package! typescript-mode)

;; For better web development
(package! web-mode)

;; For Astro files specifically
(package! astro-ts-mode)
