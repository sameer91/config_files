;;; init.el --- My emacs init.el file (Prelude & purcell's config)
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(delete-selection-mode nil)
 '(global-display-line-numbers-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "FiraCode Nerd Font" :foundry "CTDB" :slant normal :weight normal :height 128 :width normal)))))

;; UI Helpers

;;tab width
(setq-default tab-width 2)
(setq-default standard-indent 2)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
(setq-default indent-tabs-mode nil)
(setq backward-delete-char-untabify-method 'nil)


(setq custom-safe-themes t)
(global-display-line-numbers-mode)
(size-indication-mode 1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(global-prettify-symbols-mode 1)
(setq inhibit-startup-screen t)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Adjust garbage Collection
(setq gc-cons-threshold (* 50 1024 1024))

;;; Backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; STRAIGHT bootstrap
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

(setq package-enable-at-startup nil)

;;; PACKAGES

;; Diminish
(straight-use-package 'diminish)

;; Search
(straight-use-package 'anzu)
(add-hook 'after-init-hook 'global-anzu-mode)
(setq anzu-mode-lighter "")
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)

(straight-use-package 'swiper)
(global-set-key (kbd "C-x C-/") 'swiper)

;; unique

;;; Commentary:
;;

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; ibuffer
;(straight-use-package 'fullframe)
;(with-eval-after-load 'ibuffer
;  (fullframe ibuffer ibuffer-quit))

(straight-use-package 'ibuffer-vc)
(defun ibuffer-set-up-preferred-filters ()
  (ibuffer-vc-set-filter-groups-by-vc-root)
  (unless (eq ibuffer-sorting-mode 'filename/process)
    (ibuffer-do-sort-by-filename/process)))

(add-hook 'ibuffer-hook 'ibuffer-set-up-preferred-filters)

(setq-default ibuffer-show-empty-filter-groups nil)

(with-eval-after-load 'ibuffer
  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (file-size-human-readable (buffer-size))))


;; Modify the default ibuffer-formats (toggle with `)
(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 22 22 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 12 12 :left :elide)
              " "
              vc-relative-file)
        (mark modified read-only vc-status-mini " "
              (name 22 22 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 14 14 :left :elide)
              " "
              (vc-status 12 12 :left)
              " "
              vc-relative-file)))

(setq ibuffer-filter-group-name-face 'font-lock-doc-face)

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; recentf

(add-hook 'after-init-hook 'recentf-mode)
(setq-default
 recentf-max-saved-items 1000
 ;;recentf-exclude `("/tmp/" "/ssh:" ,(concat package-user-dir "/.*-autoloads\\.el\\'"))
 )

;; minibuffer
(straight-use-package 'vertico)
(add-hook 'after-init-hook 'vertico-mode)
(straight-use-package 'embark)
(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-c C-o") 'embark-export)
  (define-key vertico-map (kbd "C-c C-c") 'embark-act))

(straight-use-package 'consult)
(global-set-key [reamap switch-to-buffer] 'consult-buffer)
(global-set-key [remap switch-to-buffer-other-window] 'consult-buffer-other-window)
(global-set-key [remap switch-to-buffer-other-frame] 'consult-buffer-other-frame)
(global-set-key [remap goto-line] 'consult-goto-line)

(straight-use-package 'embark-consult)
(with-eval-after-load 'embark
  (require 'embark-consult)
  (add-hook 'embark-collect-mode-hook 'embark-consult-preview-minor-mode))

(straight-use-package 'projectile)
(setq-default consult-project-root-function 'projectile-project-root)

(straight-use-package 'marginalia)
(add-hook 'after-init-hook 'marginalia-mode)

;; Themes
(straight-use-package 'monokai-pro-theme)
(straight-use-package 'spacemacs-theme)
(load-theme 'spacemacs-dark)

(straight-use-package 'dimmer)
(setq-default dimmer-fraction 0.15)
(add-hook 'after-init-hook 'dimmer-mode)

(straight-use-package 'diredfl)
(with-eval-after-load 'dired
  (diredfl-global-mode)
  (require 'dired-x))
(define-key ctl-x-map "\C-j" 'dired-jump)
(define-key ctl-x-4-map "\C-j" 'dired-jump-other-window)

(straight-use-package 'diff-hl)
(add-hook 'after-init-hook 'global-diff-hl-mode)
(add-hook 'diff-hl-mode-hook 'diff-hl-margin-mode)
(add-hook 'diff-hl-mode-hook 'diff-hl-flydiff-mode)
(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))
(with-eval-after-load 'diff-hl
  (define-key diff-hl-mode-map
    (kbd "<left-fringe> <mouse-1>")
    'diff-hl-diff-goto-hunk)
  (define-key diff-hl-mode-map
    (kbd "<left-margin> <mouse-1>")
    'diff-hl-diff-goto-hunk))

;; expand
(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

;; Windows
(add-hook 'after-init-hook 'winner-mode)

(straight-use-package 'switch-window)
(setq-default switch-window-shortcut-style 'alphabet)
(setq-default switch-window-timeout nil)
(global-set-key (kbd "C-x o") 'switch-window)

;; Flycheck
(straight-use-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; LSP
(straight-use-package 'lsp-mode)
(add-hook 'lsp-mode 'lsp-enable-which-key-integration)
(setq lsp-idle-delay 0.05
      lsp-headerline-breadcrumb-enable 1
      lsp-keymap-prefix "C-c l"
      lsp-ui-sideline-show-hover nil
      lsp-ui-doc-include-signature t
      lsp-ui-sideline-show-symbol nil
      lsp-lens-enable nil
      )
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'lua-mode-hook #'lsp)

(straight-use-package 'lsp-ui)
(add-hook 'lsp-mode #'lsp-ui-mode)

;;(straight-use-package 'eglot)
;;(straight-use-package 'consult-eglot)
(straight-use-package 'ccls)
(add-hook 'c-mode #'(lambda () (require 'ccls) (lsp)))
(add-hook 'c++-mode #'(lambda () (require 'ccls) (lsp)))
(setq ccls-sem-highlight-method 'font-lock)
;; (add-hook 'lsp-ccls-after-open-hook #'ccls-code-lens-mode)

(defun ccls/callee () (interactive) (lsp-ui-peek-find-custom "$ccls/call" '(:callee t)))
(defun ccls/caller () (interactive) (lsp-ui-peek-find-custom "$ccls/call"))
(defun ccls/vars (kind) (lsp-ui-peek-find-custom "$ccls/vars" `(:kind ,kind)))
(defun ccls/base (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels)))
(defun ccls/derived (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels :derived t)))
(defun ccls/member (kind) (interactive) (lsp-ui-peek-find-custom "$ccls/member" `(:kind ,kind)))

;; References w/ Role::Role
(defun ccls/references-read () (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
    (plist-put (lsp--text-document-position-params) :role 8)))

;; References w/ Role::Write
(defun ccls/references-write ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 16)))

;; References w/ Role::Dynamic bit (macro expansions)
(defun ccls/references-macro () (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 64)))

;; References w/o Role::Call bit (e.g. where functions are taken addresses)
(defun ccls/references-not-call () (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :excludeRole 32)))

;; ccls/vars ccls/base ccls/derived ccls/members have a parameter while others are interactive.
;; (ccls/base 1) direct bases
;; (ccls/derived 1) direct derived
;; (ccls/member 2) => 2 (Type) => nested classes / types in a namespace
;; (ccls/member 3) => 3 (Func) => member functions / functions in a namespace
;; (ccls/member 0) => member variables / variables in a namespace
;; (ccls/vars 1) => field
;; (ccls/vars 2) => local variable
;; (ccls/vars 3) => field or local variable. 3 = 1 | 2
;; (ccls/vars 4) => parameter

;; References whose filenames are under this project
;; (lsp-ui-peek-find-references nil (list :folders (vector (projectile-project-root))))




;; Company
(straight-use-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.0
      company-minimum-prefix-length 1)
(straight-use-package 'company-quickhelp)

(company-quickhelp-mode 1)

;; HELM
(straight-use-package 'helm)
(require 'helm)
;(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
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
      helm-autoresize-mode 1
      helm-autoresize-max-height 0
      helm-autoresize-min-height 20
      helm-echo-input-in-header-line t)
(helm-autoresize-mode 1)
(helm-mode 1)

;; Corfu/Completion

;;(setq tab-always-indent 'complete)
;;(straight-use-package 'orderless)
;;(with-eval-after-load 'vertico
;;  (require 'orderless)
;;  (setq completion-styles '(orderless basic partial-completion)))

;;(straight-use-package 'corfu)
;;(setq-default corfu-auto t)
;;(setq-default corfu-quit-no-match 'separator)
;;(setq-local corfu-auto-delay 0)
;;(setq-local corfu-auto-prefix 0)
;;(add-hook 'after-init-hook 'global-corfu-mode)
;;
;;(straight-use-package 'corfu-doc)
;;(with-eval-after-load 'corfu
;;  (add-hook 'corfu-mode-hook #'corfu-doc-mode))

;; Editing Utils
(straight-use-package 'unfill)
(add-hook 'after-init-hook 'electric-pair-mode)

(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (locate-user-emacs-file ".bookmark.el")
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil
 create-lockfiles nil
 auto-save-default nil
 make-backup-file nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-margin 0
 scroll-conservatively 1000
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil)

(add-hook 'after-init-hook 'delete-selection-mode)
(add-hook 'after-init-hook 'global-auto-revert-mode)
(with-eval-after-load 'autorevert
  (diminish 'auto-revert-mode))
(add-hook 'after-init-hook 'transient-mark-mode)

(straight-use-package 'mode-line-bell)
(add-hook 'after-init-hook 'mode-line-bell-mode)

(straight-use-package 'beacon)
(setq-default beacon-lighter "")
(setq-default beacon-size 20)
(add-hook 'after-init-hook 'beacon-mode)

(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(straight-use-package 'browse-kill-ring)
(setq browse-kill-ring-separator "\f")
(global-set-key (kbd "M-Y") 'browse-kill-ring)
(with-eval-after-load 'browse-kill-ring
  (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit)
  (define-key browse-kill-ring-mode-map (kbd "M-n") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "M-p") 'browse-kill-ring-previous))
(with-eval-after-load 'page-break-lines
  (add-to-list 'page-break-lines-modes 'browse-kill-ring-mode))

;; Don't disable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
;; Don't disable case-change functions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(add-hook 'after-init-hook 'show-paren-mode)

(straight-use-package 'avy)
(global-set-key (kbd "C-;") 'avy-goto-char-timer)

(straight-use-package 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(straight-use-package 'page-break-lines)
(add-hook 'after-init-hook 'global-page-break-lines-mode)
(with-eval-after-load 'page-break-lines
  (diminish  'page-break-lines-mode))

(straight-use-package 'highlight-escape-sequences)
(add-hook 'after-init-hook 'hes-mode)

(straight-use-package 'which-key)
(add-hook 'after-init-hook 'which-key-mode)
(setq-default which-key-idle-delay 1.5)
(with-eval-after-load 'which-key
  (diminish 'which-key-mode))

(straight-use-package 'whitespace-cleanup-mode)
(add-hook 'after-init-hook 'global-whitespace-cleanup-mode)
(with-eval-after-load 'whitespace-cleanup-mode
  (diminish 'whitespace-cleanup-mode))

;;; Version Control
(straight-use-package 'git-blamed)
(straight-use-package 'git-modes)
(straight-use-package 'git-timemachine)
(global-set-key (kbd "C-x v t") 'git-timemachine-toggle)

(straight-use-package 'git-link)
(straight-use-package 'magit)
(setq-default magit-diff-refine-hunk t)
(global-set-key (kbd "C-x g") 'magit-status)
(with-eval-after-load 'magit
  (fullframe magit-status magit-mode-quit-window))

;;; Projectile
(straight-use-package 'projectile)
(add-hook 'after-init-hook 'projectile-mode)
(setq-default projectile-mode-line-prefix " Proj")
(with-eval-after-load 'projectile
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(straight-use-package 'ibuffer-projectile)

;;; Folding
(straight-use-package 'origami)
(add-hook 'after-init-hook 'origami-mode)
(with-eval-after-load 'origami
  (define-key origami-mode-map (kbd "C-c f") 'origami-recursively-toggle-node)
  (define-key origami-mode-map (kbd "C-c F") 'origami-toggle-all-nodes))

;;; misc
(straight-use-package 'lua-mode)

(straight-use-package 'uptimes)
(setq-default uptime-keep-count 200)
(add-hook 'after-init-hook (lambda () (require 'uptimes)))

;;; TReemacs & veterm
;; cleanup later
(straight-use-package 'treemacs)
(straight-use-package 'lsp-treemacs)
(straight-use-package 'vterm)
(straight-use-package 'magit)
;; Yasnippet
(straight-use-package 'yasnippet)

(straight-use-package 'yasnippet-snippets)
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;;; Access from emacsclient
(add-hook 'after-init-hook (lambda () (require 'server) (unless (server-running-p) (server-start))))


(provide 'init)

;;; init.el ends here
