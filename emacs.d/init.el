;;; init.el --- emacs init.el
;;; Commentary:
;;; Code:


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(custom-safe-themes
   '("e93f5dd31f755a6d8a845efca6eee237ccaeb9a4dc58d60a6c6e832b7ac1bfaa" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" "5846b39f2171d620c45ee31409350c1ccaddebd3f88ac19894ae15db9ef23035" "46b2d7d5ab1ee639f81bde99fcd69eb6b53c09f7e54051a591288650c29135b0" "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb" default))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
	 ("NEXT" . "#dc752f")
	 ("THEM" . "#2d9574")
	 ("PROG" . "#4f97d7")
	 ("OKAY" . "#4f97d7")
	 ("DONT" . "#f2241f")
	 ("FAIL" . "#f2241f")
	 ("DONE" . "#86dc2f")
	 ("NOTE" . "#b1951d")
	 ("KLUDGE" . "#b1951d")
	 ("HACK" . "#b1951d")
	 ("TEMP" . "#b1951d")
	 ("FIXME" . "#dc752f")
	 ("XXX+" . "#dc752f")
	 ("\\?\\?\\?+" . "#dc752f")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(nimbus-theme undo-fu evil spacemacs-theme zenburn-theme rainbow-delimiters vterm company-quickhelp helm yasnippet company async avy slime-company slime company-lua lua-mode lsp-mode company-box poweline yasnippet-snippets which-key use-package undo-tree treemacs-icons-dired treemacs-evil switch-window swiper spaceline smartparens smart-mode-line-powerline-theme page-break-lines monokai-theme magit lsp-ui helm-lsp git-gutter flycheck expand-region diminish crux company-lsp company-irony company-c-headers ccls beacon auto-package-update))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e")))

;;--------------------------------------

;; (setq gc-cons-threshold most-positive-fixnum
;;	  gc-cons-percentage 0.6)

(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

(setq load-prefer-newer noninteractive)

;;(setq user-emacs-directory (file-name-directory load-file-name))

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

;;;;pair-matching
;;(setq electric-pair-pairs '(
;;							(?\{ . ?\})
;;							(?\( . ?\))
;;							(?\[ . ?\])
;;							(?\" . ?\")
;;							))
;;(electric-pair-mode t)

;; screate window and follow
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


(global-set-key (kbd "s-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-C-<down>") 'shrink-window)
(global-set-key (kbd "s-C-<up>") 'enlarge-window)

(global-auto-revert-mode t)
(setq use-package-always-defer t)

;;tabbing
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method 'nil)

;;clean whitespaces before saving
(add-hook 'before-save-hook 'whitespace-cleanup)

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
  :init
  (spaceline-emacs-theme)
  :hook
  ('after-init-hook) . 'powerline-reset)

(use-package rainbow-delimiters
  :ensure t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package smartparens
  :ensure t
;;  :diminish smartparens-mode
  :config
  (progn
	(require 'smartparens-config)
	(smartparens-global-mode 1)
	(show-paren-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

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

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode))

(use-package swiper
  :ensure t
  :bind ("C-s" . 'swiper))

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

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode)

(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))

(use-package vterm
  :ensure t)

(use-package company
  :ensure t
;;  :diminish company-mode
  :init
  (add-hook 'after-init-hook #'global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)

 ;; :config
 ;; (company-tng-configure-default)
  ;;(setq lsp-completion-provider :capf)
  )
;;(global-set-key "\t" 'company-complete-common)

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode)
  )

(use-package company-lua
  :ensure t
  )

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))



(use-package projectile
  :ensure t
  :disabled t
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


(use-package helm
  :ensure t
  :defer 2
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (require 'helm-config)
  (helm-mode 1)
  ;;(helm-autoresize-mode 1)
  ;;(setq helm-split-window-inside-p t
  ;;	helm-move-to-line-cycle-in-source t)
  ;; (setq helm-autoresize-max-height 0)
  ;; (setq helm-autoresize-min-height 20)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  )

(use-package helm-projectile
  :ensure t
  :disabled t
  :config
  (helm-projectile-on))

;;LSP
(use-package lsp-mode
  :ensure t
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-ui :ensure t :commands lsp-ui-mode)
(use-package helm-lsp :ensure t :commands helm-lsp-workspace-symbols)
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package company-lsp :commands company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))
;;(use-package company-box
;;  :ensure t
;;  :hook (company-mode . company-box-mode))

(use-package ccls
   :ensure t
   :config
   ;;(setq ccls-executable "/home/sameer/Code/ccls/Release/ccls")
   (setq ccls-executable "/usr/bin/ccls")
   (setq lsp-prefer-flymake nil)
   (setq-default flycheck-disabled-checkers
				 '(c/c++-clang c/c++-cppcheck c/c++-gcc))
   :hook ((c-mode c++-mode objc-mode cuda-mode) .
		  (lambda () (require 'ccls) (lsp))))


;; (use-package evil
;;   :ensure t
;;   :init (evil-mode 1))

(use-package undo-tree
  :ensure t)
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
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "JB  " :slant normal :weight normal :height 120 :width normal)))))

;;set cursor color
;;(set-cursor-color "white")


(require 'frame)
 (defun set-cursor-hook (frame)
 (modify-frame-parameters
   frame (list (cons 'cursor-color "white"))))

(add-hook 'after-make-frame-functions 'set-cursor-hook)


(provide 'init)

;;; init.el ends here
