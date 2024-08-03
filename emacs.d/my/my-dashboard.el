;;; -*- lexical-binding:t ; no-byte-compile: t; -*-

(use-package page-break-lines
  :straight t
  :defer t
  :init
  (page-break-lines-mode))

(use-package dashboard
  :straight t
  :defer t
  :init
  (dashboard-setup-startup-hook))

(provide 'my-dashboard)
