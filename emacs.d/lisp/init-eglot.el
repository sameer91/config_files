;;; init-eglot.el --- LSP support via eglot          -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(when (maybe-require-package 'eglot)
  (maybe-require-package 'consult-eglot))

(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'python-mode-hook #'eglot-ensure)
(add-hook 'c-ts-mode-hook #'eglot-ensure)
(add-hook 'c++-ts-mode-hook #'eglot-ensure)
(add-hook 'python-ts-mode-hook #'eglot-ensure)

(provide 'init-eglot)
;;; init-eglot.el ends here
