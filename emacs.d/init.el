;;; init.el --- Emacs init file
;;; Commentary:
;; Basic c/cpp development using straight.el for package management :)


;;-------------------------------------------------------------
;;--------------- Emacs Custom Variables ----------------------
;;-------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes '(wombat))
 '(custom-safe-themes
   '("ea5822c1b2fb8bb6194a7ee61af3fe2cc7e2c7bab272cbb498a0234984e1b2d9" "e7f49a69d5fed5597d37b0711ca195fd632b9b08993194cb2f1d36dd1f7b20a0" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(diff-hl-margin-mode t)
 '(global-diff-hl-mode t)
 '(global-display-line-numbers-mode t)
 '(helm-M-x-reverse-history t)
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
 '(ido-everywhere t)
 '(ido-ubiquitous-mode t)
 '(ido-vertical-mode t)
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(size-indication-mode t)
 '(sml/theme nil)
 '(switch-window-input-style 'minibuffer)
 '(switch-window-shortcut-style 'qwerty)
 '(tool-bar-mode nil)
 '(yascroll:delay-to-hide nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "IBM Plex Mono" :foundry "IBM " :slant normal :weight normal :height 120 :width normal)))))


;;-------------------------------------------------
;;--------------- General Stuff -------------------
;;-------------------------------------------------

;;; Code:

(setq gc-cons-threshold (* 100 1024 1024))
(setq load-prefer-newer noninteractive)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq large-file-warning-threshold 100000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;;visual helpers
(menu-bar-mode 1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode -1)
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

;; dired ls options (-lGah1v --group-directories-first)
(setq dired-listing-switches "-lGah1v --group-directories-first")



;; ------------------------------------------------------------------------
;; ------------------- STARIGHT.EL BOOTSTRAP CODE -------------------------
;; ------------------------------------------------------------------------

;; emacs version >=27
(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
	   (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
	  (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
	(with-current-buffer
		(url-retrieve-synchronously
		 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
		 'silent 'inhibit-cookies)
	  (goto-char (point-max))
	  (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))



(straight-use-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;-------------------------------------------------------------
;; Interface Enhabcement

;; IVY
(straight-use-package 'counsel)
(straight-use-package 'swiper)
;;(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-/") 'swiper)

;; WHICH KEY
(straight-use-package 'which-key)
(which-key-mode)

;;HELM
(straight-use-package 'helm)
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
	  helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
	  helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
	  helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
	  helm-ff-file-name-history-use-recentf t
	  helm-echo-input-in-header-line t)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

;; PRESCIENT
(straight-use-package 'prescient)
(straight-use-package 'company-prescient)
(company-prescient-mode)

;;icons
(straight-use-package 'all-the-icons)

;; PAGE_BREAK_LINES
(straight-use-package 'page-break-lines)
(page-break-lines-mode visual-line-mode)
(global-page-break-lines-mode)


;;------------------- KEY BINDINGS ---------------------------
;;EVIL MODE
;;(straight-use-package 'evil)
;;(require 'evil)
;;(evil-mode 1)

;;------------------ VISUAL ----------------------------------p
;;UNDO_TREE
(straight-use-package 'undo-tree)
(straight-use-package 'undo-fu)
(straight-use-package 'goto-chg)
(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-.") 'goto-last-change-reverse)
(global-undo-tree-mode 1)

;;RAINBOW DELIMITERS
(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;beacon
(straight-use-package 'beacon)
(beacon-mode 1)

;;DIMMER
(straight-use-package 'dimmer)
(dimmer-configure-which-key)
(dimmer-configure-helm)
(dimmer-mode t)

;;scroll
(straight-use-package 'yascroll)
(global-yascroll-bar-mode t)

;; windows switch
(straight-use-package 'switch-window)
(setq switch-window-input-style 'minibuffer)
(setq switch-window-increase 4)
(setq switch-window-threshold 2)
(setq switch-window-shor2tcut-style 'qwerty)
(setq switch-window-qwerty-shortcuts
	  '("a" "s" "d" "f" "j" "k" "l"))
(global-set-key (kbd "C-x o") 'switch-window)

;;------------------- EDITING ---------------------------------
;; EXPAND-REGION
(straight-use-package 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)

;;avy
(straight-use-package 'avy)
(global-set-key (kbd "M-s") 'avy-goto-charq)

;;CRUX
(straight-use-package 'crux)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
(global-set-key (kbd "C-c f") 'crux-recentf-find-file)
(global-set-key (kbd "C-a") 'crux-move-beginning-of-line)

;;------------------- PROJECT MGMT------------------------------
;;projectile
(straight-use-package 'projectile)
(projectile-mode +1)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;------------------- PROGRAMMING -----------------------------
;; Yasnippet
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; smartparens
(straight-use-package 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-global-mode t)

;; lsp
(straight-use-package 'lsp-mode)
;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "C-c l")

(add-hook 'lsp-mode 'lsp-enable-which-key-integration)
(setq lsp-idle-delay 0.1)
(setq lsp-headerline-breadcrumb-enable 1)
;;(add-hook 'prog-mode-hook 'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
;;(add-hook 'haskell-mode-hook #'lsp)

(straight-use-package 'lsp-ui)
(straight-use-package 'helm-lsp)

;; code format
(straight-use-package 'format-all)

;; Completion

(straight-use-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.0
	  company-minimum-prefix-length 1)

(straight-use-package 'company-quickhelp)
(company-quickhelp-mode)

;;----------------- Integration --------------------------
;;vterm
(straight-use-package 'vterm)


;; version control
;;magit
(straight-use-package 'magit)
(global-set-key (kbd "C-M-g") 'magit-status)
;;diff-hl
(straight-use-package 'diff-hl)
(global-diff-hl-mode)
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;;THEMES

;;powerline
;; (straight-use-package 'spaceline)
;; (straight-use-package 'powerline)

;; (require 'spaceline-config)
;; (spaceline-spacemacs-theme)

;;smart-mode-line

(straight-use-package 'smart-mode-line)
(straight-use-package 'zerodark-theme)
(load-theme 'zerodark t)
;; Optionally setup the modeline
(zerodark-setup-modeline-format)


(provide 'init)

;;; init.el ends here
