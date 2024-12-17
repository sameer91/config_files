;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-tomorrow-night t)
  (doom-themes-org-config))


(use-package nerd-icons
  :straight t)

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode)
  :custom
  (doom-modeline-icon (display-graphic-p))
  (doom-modeline-mu4e t))

(provide 'my-theme)
