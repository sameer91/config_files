;;; init.el --- emacs init.el
;;; Commentary:
;;; Code:
;;--------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))


(setq gc-cons-threshold (* 100 1024 1024))

(setq load-prefer-newer noninteractive)

(setq read-process-output-max (* 1024 1024)) ;; 1mb

(setq large-file-warning-threshold 100000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;;make all commands of package module present
(require 'package)

;; Internet repository
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
						 ("gnu"   . "http://elpa.gnu.org/packages/")
						 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;;visual helpers
(menu-bar-mode 1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode +1)
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

(setq inhibit-startup-screen t)

;;show smaller paths
(setq frame-title-format
	  '((:eval (if (buffer-file-name)
	   (abbreviate-file-name (buffer-file-name))
	   "%b"))))

;;scrolling
(setq scroll-margin 5
	  scroll-conservatively 100
	  scroll-preserve-screen-position 1)

;;prettify symbol
(global-prettify-symbols-mode t)

(load-theme 'spacemacs-dark)

;;---------
;;backup
(setq backup-directory-alist
	  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

;; create window and follow
 (defun split-and-follow-horizontally ()
	(interactive)
	(split-window-below)
	(balance-windows)
	(other-window 1))
 (global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

 (defun split-and-follow-vertically ()
	(interactive)
	(split-window-right)
	(balance-windows)
	(other-window 1))
 (global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;;yes or no -> t or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Window resize
(global-set-key (kbd "s-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-C-<down>") 'shrink-window)
(global-set-key (kbd "s-C-<up>") 'enlarge-window)

(global-auto-revert-mode t)
(setq use-package-always-defer t)

;;tab width
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method 'nil)

;;clean whitespaces before saving
(add-hook 'before-save-hook 'whitespace-cleanup)

;; dired ls options
(setq dired-listing-switches "-lGah1v --group-directories-first")

;;--------------------------------------------------
(use-package auto-package-update
  :defer nil
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package diminish
  :ensure t)

(use-package spaceline
  :ensure t)
(use-package powerline
  :ensure t
  ;;:init
  ;;(spaceline-emacs-theme)
  :hook
  ('after-init-hook) . 'powerline-reset)

(use-package rainbow-delimiters
  :ensure t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :init
	(require 'smartparens-config)
	(smartparens-global-mode 1)
	(show-paren-mode t))

;;(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
;;(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

;;DONE
(use-package expand-region
  :ensure t
  :bind ("M-m" . er/expand-region))

(use-package crux
  :ensure t
  :bind
  ("C-k" . crux-smart-kill-line)
  ("C-c n" . crux-cleanup-buffer-or-region)
  ("C-c f" . crux-recentf-find-file)
  ("C-a" . crux-move-beginning-of-line))

;;DONE
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode))


;;done
(use-package counsel
  :ensure t
  :bind(
		("M-x" . 'counsel-M-x)
		("C-x C-f" . 'counsel-find-file)
		)

  )
;;done
(use-package swiper
  :ensure t
  :bind (;;("C-s" . 'swiper)
		 ("M-/" . 'swiper))
  )

(use-package beacon
  :ensure t
  :diminish beacon-mode
  :init
  (beacon-mode 1))

(use-package avy
	:ensure t
	:bind
	("M-s" . avy-goto-char))

(use-package switch-window
	:ensure t
	:config
	(setq switch-window-input-style 'minibuffer)
	(setq switch-window-increase 4)
	(setq switch-window-threshold 2)
	(setq switch-window-shortcut-style 'qwerty)
	(setq switch-window-qwerty-shortcuts
		  '("a" "s" "d" "f" "j" "k" "l"))
	:bind
	([remap other-window] . switch-window))

(use-package async
	:ensure t
	:init
	(dired-async-mode 1))

(use-package page-break-lines
  :ensure t
  :diminish (page-break-lines-mode visual-line-mode))

(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))

(use-package vterm
  :ensure t)

;; done
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-company-mode '(not gud-mode))
  (setq company-idle-delay 0.0
		company-minimum-prefix-length 1))

;;DONE
(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode)
  )

(use-package company-lua
  :ensure t)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind
  (("C-c p f" . helm-projectile-find-file)
   ("C-c p p" . helm-projectile-switch-project)
   ("C-c p s" . projectile-save-project-buffers))
  :config
  (projectile-mode +1)
  )


(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook
  ((c-mode c++-mode) . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t)

;;DONE
(use-package helm
 :ensure t
 :defer 2
 :bind
;; ("M-x" . helm-M-x)
;; ("C-x C-f" . helm-find-files)
;; ("M-y" . helm-show-kill-ring)
;; ("C-x b" . helm-mini)
 :init
 (require 'helm-config)
 (helm-mode 1)
 ;;(helm-autoresize-mode 1)
 :config
 (setq helm-split-window-inside-p t
	helm-scroll-amount 8
	helm-candidate-number-limit 50
	;; Remove extraineous helm UI elements
	helm-display-header-line nil
	helm-mode-line-string nil
	;; Default helm window sizes
	helm-display-buffer-default-width nil
	;;helm-display-buffer-default-height 0.25
	)
 ;;(setq helm-autoresize-max-height 0)
 ;;(setq helm-autoresize-min-height 20)
 (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
 (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
 (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
 )

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
	(define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
	(setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
		  treemacs-deferred-git-apply-delay      0.5
		  treemacs-directory-name-transformer    #'identity
		  treemacs-display-in-side-window        t
		  treemacs-eldoc-display                 t
		  treemacs-file-event-delay              5000
		  treemacs-file-extension-regex          treemacs-last-period-regex-value
		  treemacs-file-follow-delay             0.2
		  treemacs-file-name-transformer         #'identity
		  treemacs-follow-after-init             t
		  treemacs-git-command-pipe              ""
		  treemacs-goto-tag-strategy             'refetch-index
		  treemacs-indentation                   2
		  treemacs-indentation-string            " "
		  treemacs-is-never-other-window         nil
		  treemacs-max-git-entries               5000
		  treemacs-missing-project-action        'ask
		  treemacs-move-forward-on-expand        nil
		  treemacs-no-png-images                 nil
		  treemacs-no-delete-other-windows       t
		  treemacs-project-follow-cleanup        nil
		  treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
		  treemacs-position                      'left
		  treemacs-read-string-input             'from-child-frame
		  treemacs-recenter-distance             0.1
		  treemacs-recenter-after-file-follow    nil
		  treemacs-recenter-after-tag-follow     nil
		  treemacs-recenter-after-project-jump   'always
		  treemacs-recenter-after-project-expand 'on-distance
		  treemacs-show-cursor                   nil
		  treemacs-show-hidden-files             t
		  treemacs-silent-filewatch              nil
		  treemacs-silent-refresh                nil
		  treemacs-sorting                       'alphabetic-asc
		  treemacs-space-between-root-nodes      t
		  treemacs-tag-follow-cleanup            t
		  treemacs-tag-follow-delay              1.5
		  treemacs-user-mode-line-format         nil
		  treemacs-user-header-line-format       nil
		  treemacs-width                         35
		  treemacs-workspace-switch-cleanup      nil)

	;; The default width and height of the icons is 22 pixels. If you are
	;; using a Hi-DPI display, uncomment this to double the icon size.
	;;(treemacs-resize-icons 44)

	(treemacs-follow-mode t)
	(treemacs-filewatch-mode t)
	(treemacs-fringe-indicator-mode 'always)
	(pcase (cons (not (null (executable-find "git")))
				 (not (null treemacs-python-executable)))
	  (`(t . t)
	   (treemacs-git-mode 'deferred))
	  (`(t . _)
	   (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
		("M-0"       . treemacs-select-window)
		("C-x t 1"   . treemacs-delete-other-windows)
		("C-x t t"   . treemacs)
		("C-x t B"   . treemacs-bookmark)
		("C-x t C-t" . treemacs-find-file)
		("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after treemacs persp-mode ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))


;; LSP
(use-package lsp-mode
  :ensure t
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :init
  (setq lsp-idle-delay 0.1)
  (setq lsp-headerline-breadcrumb-enable 1))

;;(add-hook 'prog-mode-hook 'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'haskell-mode-hook #'lsp)

(use-package lsp-ui :ensure t :commands lsp-ui-mode)
(use-package helm-lsp :ensure t :commands helm-lsp-workspace-symbols)
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)

(use-package dap-mode :ensure t)
(require 'dap-gdb-lldb)
(use-package which-key
  :ensure t
  :config
  (which-key-mode))



; Undo Tree Mode
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package undo-fu
  :ensure t)
(use-package goto-chg
  :ensure t)

;;---------------------------------------------------------
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "MesloLGS NF" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal)))))

;;set cursor color
;;(set-cursor-color "white")


(require 'frame)
 (defun set-cursor-hook (frame)
 (modify-frame-parameters
   frame (list (cons 'cursor-color "white"))))

(add-hook 'after-make-frame-functions 'set-cursor-hook)


(provide 'init)

;;; init.el ends here
