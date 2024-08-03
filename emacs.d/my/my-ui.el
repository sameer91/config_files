;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; UI Helper
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "UKWN" :slant normal :weight regular :height 143 :width normal)))))

(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (locate-user-emacs-file ".bookmark.el")
 buffers-menu-max-size 50
 case-fold-search t
 column-number-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-window-plain
 create-lockfiles nil
 auto-save-default nil
 ;; make-backup-files nil
 scroll-margin 5
 scroll-conservatively 1000
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil

 ;;Tabs
 tab-width 2
 standard-indent 2
 electric-indent-inhibit t
 indent-tabs-mode nil

 ;; Better defaults
 save-interprogram-paste-before-kill t
 apropos-do-all t
 mouse-yank-at-point t
 require-final-newline t
 visible-bell t
 load-prefer-newer t
 backup-by-copying t
 frame-inhibit-implied-resize t
 )


(setq
 default-frame-alist '((fullscreen . maximized))
 custom-safe-themes t
 inhibit-startup-screen t
 ;; Tabs
 c-basic-offset tab-width
 backward-delete-char-untabify-method 'nil
 )

;; handle backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; use y/n
(defalias 'yes-or-no-p 'y-or-n-p)


(global-display-line-numbers-mode 1)
(size-indication-mode 1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(global-prettify-symbols-mode -1)
(global-hl-line-mode 1)

(recentf-mode 1)
;; Save what you enter into minibuffer prompts
(setq history-length 25)
(savehist-mode 1)
;; Remember and restore the last cursor location of opened files
(save-place-mode 1)
;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Window move
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(provide 'my-ui)
