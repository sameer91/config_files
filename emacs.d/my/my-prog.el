;;; -*- no-byte-compile: t; -*-

(add-hook 'prog-mode-hook 'electric-pair-mode)

(use-package yasnippet
  :straight t
  :defer t
  :init
  (yas-global-mode))

(use-package yasnippet-snippets
  :straight t
  :defer t)

(use-package tree-sitter
  :straight t
  :defer t
  :init
  (global-tree-sitter-mode)
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode))
(use-package tree-sitter-langs
  :straight t
  :defer t)

(setq treesit-extra-load-path '("~/.emacs.d/straight/build/tree-sitter-langs/bin/"))
;; (add-to-list 'auto-mode-alist '("\\(?:CMakeLists\\.txt|\\.cmake\\)\\'" . cmake-ts-mode))

;; (use-package cmake-mode
;;   :straight t
;;   :defer t)
;; (add-hook 'cmake-mode-hook . cmake-mode)
;; (add-hook 'cmake-ts-mode-hook . cmake-mode)

(use-package diff-hl
  :straight t
  :defer t
  :init
  (global-diff-hl-mode)
  :hook
  (diff-hl-mode . diff-hl-margin-mode)
  (diff-hl-mode . diff-hl-flydiff-mode))
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook ' diff-hl-dired-mode))
(with-eval-after-load 'diff-hl
  (define-key diff-hl-mode-map
              (kbd "<left-fringe> <mouse-1>")
              'diff-hl-diff-goto-hunk)
  (define-key diff-hl-mode-map
              (kbd "<left-fringe> <mouse-1>")
              'diff-hl-diff-goto-hunk))

(use-package magit
  :straight t
  :defer t
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-same-window-except-diff-v1))

(use-package git-commit
  :ensure nil
  :preface
  (defun my/git-commit-auto-fill-everywhere ()
    "Ensure that the commit body does not exceed 72 characters."
    (setq fill-column 72)
    (setq-local comment-auto-fill-only-comments nil))
  :hook (git-commit-mode . my/git-commit-auto-fill-everywhere)
  :custom (git-commit-summary-max-length 50))

(use-package smerge-mode
  :after hydra
  :delight " ∓"
  :commands smerge-mode
  :bind (:map smerge-mode-map
              ("M-g n" . smerge-next)
              ("M-g p" . smerge-prev))
  :hook (magit-diff-visit-file . hydra-merge/body))

;; Company
(use-package company
  :straight t
  :defer t
  :hook
  (after-init . global-company-mode)
  :custom
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1))
(use-package company-quickhelp
  :straight t
  :defer t
  :init
  (company-quickhelp-mode 1))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(provide 'my-prog)
