;;; init.el --- My emacs init.el file (Prelude & purcell's config)
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes nil)
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
 '(default ((t (:family "Iosevka" :foundry "UKWN" :slant normal :weight normal :height 143 :width normal)))))

;; UI Helpers
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

;; Remember last edit
(save-place-mode 1)

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
;;=======================
;; Interface Enhancements
;;=======================

;; Icons
(straight-use-package 'all-the-icons)
(when (display-graphic-p)
  (require 'all-the-icons))

;; Help
(straight-use-package 'helpful)
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)

(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)
;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; Beacon
(straight-use-package 'beacon)
(setq-default beacon-lighter "")
(setq-default beacon-size 20)
(add-hook 'after-init-hook 'beacon-mode)

;; Highlights
(straight-use-package 'volatile-highlights)
(add-hook 'after-init-hook 'volatile-highlights-mode)

;; Window move
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; Tabbar
(straight-use-package 'centaur-tabs)
(setq centaur-tabs-style "bar")
(setq centaur-tabs-height 32)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-plain-icons t)
(setq centaur-tabs-set-bar 'under)
(setq x-underline-at-descent-line t)
(setq centaur-tabs-cycle-scope 'tabs)
(setq centaur-tabs-enable-key-bindings t)
;;(centaur-tabs-mode t)
(add-hook 'after-init-hook 'centaur-tabs-mode)
(defun centaur-tabs-hide-tab (x)
  "Do no to show buffer X in tabs."
  (let ((name (format "%s" x)))
    (or
     ;; Current window is not dedicated window.
     (window-dedicated-p (selected-window))

     ;; Buffer name not match below blacklist.
     (string-prefix-p "*epc" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*Helm" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (string-prefix-p "*company" name)
     (string-prefix-p "*Flycheck" name)
     (string-prefix-p "*tramp" name)
     (string-prefix-p " *Mini" name)
     (string-prefix-p "*help" name)
     (string-prefix-p "*straight" name)
     (string-prefix-p " *temp" name)
     (string-prefix-p "*Help" name)
     (string-prefix-p "*mybuf" name)

     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
          (not (file-name-extension name)))
     )))
(global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)
(add-hook 'dired-mode-hook 'centaur-tabs-local-mode)

;; Avy
(straight-use-package 'avy)
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-:") 'avy-goto-char-timer)

;; Anzu
(straight-use-package 'anzu)
(add-hook 'after-init-hook 'global-anzu-mode)
(add-hook 'after-init-hook 'anzu-mode)
(setq anzu-mode-lighter "")
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)

;; Which key
(straight-use-package 'which-key)
(add-hook 'after-init-hook 'which-key-mode)
(setq-default which-key-idle-delay 0.5)
(with-eval-after-load 'which-key
(diminish 'which-key-mode))

;; Ivy
(straight-use-package 'ivy)
(straight-use-package 'counsel)
(straight-use-package 'swiper)
(add-hook 'after-init-hook 'ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
(setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c SPC") 'centaur-tabs-counsel-switch-group)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; Prescient
(straight-use-package 'prescient)
(straight-use-package 'company-prescient)
(add-hook 'company-mode-hook 'company-prescient-mode)
(straight-use-package 'ivy-prescient)
;;(ivy-prescient-mode)

;; modeline
(straight-use-package 'nyan-mode)
(add-hook 'after-init-hook 'nyan-mode)
(straight-use-package 'spaceline)
(add-hook 'after-init-hook 'spaceline-emacs-theme)

;; Solaire mode
(straight-use-package 'solaire-mode)
(add-hook 'after-init-hook 'solaire-global-mode)

;; CRUX
(straight-use-package 'crux)
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)
(global-set-key (kbd "C-c o") #'crux-open-with)
(global-set-key [(shift return)] #'crux-smart-open-line)
(global-set-key (kbd "s-r") #'crux-recentf-find-file)
(global-set-key (kbd "C-<backspace>") #'crux-kill-line-backwards)
(global-set-key [remap kill-whole-line] #'crux-kill-whole-line)

;; highlight words
(straight-use-package 'highlight-symbol)
(add-to-list 'after-init-hook #'highlight-symbol-mode)

;; whitespace cleanup
(straight-use-package 'whitespace-cleanup-mode)
(add-hook 'prog-mode-hook 'whitespace-cleanup-mode)

;; Undo
(straight-use-package 'undo-fu)
(setq undo-limit 67108864) ; 64mb.
(setq undo-strong-limit 100663296) ; 96mb.
(setq undo-outer-limit 1006632960) ; 960mb.
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z")   'undo-fu-only-undo)
(global-set-key (kbd "C-S-z") 'undo-fu-only-redo)

;; Browse kill ring
(straight-use-package 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; Snippets
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(add-hook 'after-init-hook 'yas-global-mode)

;; Company
(straight-use-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.0
      company-minimum-prefix-length 1)
(straight-use-package 'company-quickhelp)
(company-quickhelp-mode 1)

;;; Projectile
(straight-use-package 'projectile)
(add-hook 'after-init-hook 'projectile-mode)
(setq-default projectile-mode-line-prefix " Proj")
(with-eval-after-load 'projectile
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(straight-use-package 'ibuffer-projectile)

;; LSP
(straight-use-package 'lsp-mode)
(add-hook 'lsp-mode 'lsp-enable-which-key-integration)
(setq lsp-idle-delay 0.05
      lsp-headerline-breadcrumb-enable 1
      lsp-keymap-prefix "C-c l"
      lsp-ui-sideline-show-hover nil
      lsp-ui-doc-include-signature t
      lsp-ui-doc-enable t
      lsp-ui-doc-use-childframe t
      lsp-ui-doc-show-with-cursor t
      lsp-ui-doc-position "top"
      lsp-ui-sideline-show-symbol nil
      lsp-lens-enable nil
      )
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'lua-mode-hook #'lsp)

(straight-use-package 'lsp-ui)
(add-hook 'lsp-mode #'lsp-ui-mode)

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

;; References whose filenames are under this project
;; (lsp-ui-peek-find-references nil (list :folders (vector (projectile-project-root))))

;; Flycheck
(straight-use-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Themes
(straight-use-package 'monokai-pro-theme)
(straight-use-package 'spacemacs-theme)
(load-theme 'spacemacs-dark)


;; ;;---------------------------------------------------;;
;; FIX THIS LATER ???
;;
;; ;; unique
;;
;; ;;; Commentary:
;; ;;
;;
;; (require 'uniquify)
;; (setq uniquify-buffer-name-style 'reverse)
;; (setq uniquify-separator " • ")
;; (setq uniquify-after-kill-buffer-p t)
;; (setq uniquify-ignore-buffers-re "^\\*")
;;
;; ;; ibuffer
;; ;(straight-use-package 'fullframe)
;; ;(with-eval-after-load 'ibuffer
;; ;  (fullframe ibuffer ibuffer-quit))
;;
;; (straight-use-package 'ibuffer-vc)
;; (defun ibuffer-set-up-preferred-filters ()
;;   (ibuffer-vc-set-filter-groups-by-vc-root)
;;   (unless (eq ibuffer-sorting-mode 'filename/process)
;;     (ibuffer-do-sort-by-filename/process)))
;;
;; (add-hook 'ibuffer-hook 'ibuffer-set-up-preferred-filters)
;;
;; (setq-default ibuffer-show-empty-filter-groups nil)
;;
;; (with-eval-after-load 'ibuffer
;;   ;; Use human readable Size column instead of original one
;;   (define-ibuffer-column size-h
;;     (:name "Size" :inline t)
;;     (file-size-human-readable (buffer-size))))
;;
;;
;; ;; Modify the default ibuffer-formats (toggle with `)
;; (setq ibuffer-formats
;;       '((mark modified read-only vc-status-mini " "
;;               (name 22 22 :left :elide)
;;               " "
;;               (size-h 9 -1 :right)
;;               " "
;;               (mode 12 12 :left :elide)
;;               " "
;;               vc-relative-file)
;;         (mark modified read-only vc-status-mini " "
;;               (name 22 22 :left :elide)
;;               " "
;;               (size-h 9 -1 :right)
;;               " "
;;               (mode 14 14 :left :elide)
;;               " "
;;               (vc-status 12 12 :left)
;;               " "
;;               vc-relative-file)))
;;
;; (setq ibuffer-filter-group-name-face 'font-lock-doc-face)
;;
;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;;
;; ;; recentf
;;
;; (add-hook 'after-init-hook 'recentf-mode)
;; (setq-default
;;  recentf-max-saved-items 1000
;;  ;;recentf-exclude `("/tmp/" "/ssh:" ,(concat package-user-dir "/.*-autoloads\\.el\\'"))
;;  )
;;
;; ;; minibuffer
;; (straight-use-package 'vertico)
;; (add-hook 'after-init-hook 'vertico-mode)
;; (straight-use-package 'embark)
;; (with-eval-after-load 'vertico
;;   (define-key vertico-map (kbd "C-c C-o") 'embark-export)
;;   (define-key vertico-map (kbd "C-c C-c") 'embark-act))
;;
;; (straight-use-package 'consult)
;; (global-set-key [reamap switch-to-buffer] 'consult-buffer)
;; (global-set-key [remap switch-to-buffer-other-window] 'consult-buffer-other-window)
;; (global-set-key [remap switch-to-buffer-other-frame] 'consult-buffer-other-frame)
;; (global-set-key [remap goto-line] 'consult-goto-line)
;;
;; (straight-use-package 'embark-consult)
;; (with-eval-after-load 'embark
;;   (require 'embark-consult)
;;   (add-hook 'embark-collect-mode-hook 'embark-consult-preview-minor-mode))
;;
;; (straight-use-package 'projectile)
;; (setq-default consult-project-root-function 'projectile-project-root)
;;
;; (straight-use-package 'marginalia)
;; (add-hook 'after-init-hook 'marginalia-mode)
;;
;;
;; (straight-use-package 'dimmer)
;; (setq-default dimmer-fraction 0.15)
;; (add-hook 'after-init-hook 'dimmer-mode)
;;
;; (straight-use-package 'diredfl)
;; (with-eval-after-load 'dired
;;   (diredfl-global-mode)
;;   (require 'dired-x))
;; (define-key ctl-x-map "\C-j" 'dired-jump)
;; (define-key ctl-x-4-map "\C-j" 'dired-jump-other-window)
;;
;; (straight-use-package 'diff-hl)
;; (add-hook 'after-init-hook 'global-diff-hl-mode)
;; (add-hook 'diff-hl-mode-hook 'diff-hl-margin-mode)
;; (add-hook 'diff-hl-mode-hook 'diff-hl-flydiff-mode)
;; (with-eval-after-load 'dired
;;   (add-hook 'dired-mode-hook 'diff-hl-dired-mode))
;; (with-eval-after-load 'diff-hl
;;   (define-key diff-hl-mode-map
;;     (kbd "<left-fringe> <mouse-1>")
;;     'diff-hl-diff-goto-hunk)
;;   (define-key diff-hl-mode-map
;;     (kbd "<left-margin> <mouse-1>")
;;     'diff-hl-diff-goto-hunk))
;;
;; ;; expand
;; (global-set-key (kbd "M-/") 'hippie-expand)
;; (setq hippie-expand-try-functions-list
;;       '(try-complete-file-name-partially
;;         try-complete-file-name
;;         try-expand-dabbrev
;;         try-expand-dabbrev-all-buffers
;;         try-expand-dabbrev-from-kill))
;;
;; ;; Windows
;; (add-hook 'after-init-hook 'winner-mode)
;;
;; (straight-use-package 'switch-window)
;; (setq-default switch-window-shortcut-style 'alphabet)
;; (setq-default switch-window-timeout nil)
;; (global-set-key (kbd "C-x o") 'switch-window)
;;

;;

;;
;;
;;
;;

;; ;; HELM
;; (straight-use-package 'helm)
;; (require 'helm)
;; ;(require 'helm-config)
;; (global-set-key (kbd "M-x") #'helm-M-x)
;; (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;; (global-set-key (kbd "C-x C-f") #'helm-find-files)
;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
;; (when (executable-find "curl")
;;   (setq helm-google-suggest-use-curl-p t))
;; 
;; (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;       helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;;       helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;;       helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;       helm-ff-file-name-history-use-recentf t
;;       helm-autoresize-mode 1
;;       helm-autoresize-max-height 0
;;       helm-autoresize-min-height 20
;;       helm-echo-input-in-header-line t)
;; (helm-autoresize-mode 1)
;; (helm-mode 1)

;; ;; Editing Utils
(straight-use-package 'unfill)
(add-hook 'after-init-hook 'electric-pair-mode)
;;

;;
;; (add-hook 'after-init-hook 'delete-selection-mode)
;; (add-hook 'after-init-hook 'global-auto-revert-mode)
;; (with-eval-after-load 'autorevert
;;   (diminish 'auto-revert-mode))
;; (add-hook 'after-init-hook 'transient-mark-mode)
;;
;; (straight-use-package 'mode-line-bell)
;; (add-hook 'after-init-hook 'mode-line-bell-mode)
;;
;;
;; (straight-use-package 'rainbow-delimiters)
;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;
;; (straight-use-package 'browse-kill-ring)
;; (setq browse-kill-ring-separator "\f")
;; (global-set-key (kbd "M-Y") 'browse-kill-ring)
;; (with-eval-after-load 'browse-kill-ring
;;   (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit)
;;   (define-key browse-kill-ring-mode-map (kbd "M-n") 'browse-kill-ring-forward)
;;   (define-key browse-kill-ring-mode-map (kbd "M-p") 'browse-kill-ring-previous))
;; (with-eval-after-load 'page-break-lines
;;   (add-to-list 'page-break-lines-modes 'browse-kill-ring-mode))
;;
;; ;; Don't disable narrowing commands
;; (put 'narrow-to-region 'disabled nil)
;; (put 'narrow-to-page 'disabled nil)
;; (put 'narrow-to-defun 'disabled nil)
;; ;; Don't disable case-change functions
;; (put 'upcase-region 'disabled nil)
;; (put 'downcase-region 'disabled nil)
;;
;; (add-hook 'after-init-hook 'show-paren-mode)
;;
;; (straight-use-package 'avy)
;; (global-set-key (kbd "C-;") 'avy-goto-char-timer)
;;
;; (straight-use-package 'multiple-cursors)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-+") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;
;; (straight-use-package 'page-break-lines)
;; (add-hook 'after-init-hook 'global-page-break-lines-mode)
;; (with-eval-after-load 'page-break-lines
;;   (diminish  'page-break-lines-mode))
;;
;; (straight-use-package 'highlight-escape-sequences)
;; (add-hook 'after-init-hook 'hes-mode)
;;
;;
;; (straight-use-package 'whitespace-cleanup-mode)
;; (add-hook 'after-init-hook 'global-whitespace-cleanup-mode)
;; (with-eval-after-load 'whitespace-cleanup-mode
;;   (diminish 'whitespace-cleanup-mode))
;;
;; ;;; Version Control
;; (straight-use-package 'git-blamed)
;; (straight-use-package 'git-modes)
;; (straight-use-package 'git-timemachine)
;; (global-set-key (kbd "C-x v t") 'git-timemachine-toggle)
;;
;; (straight-use-package 'git-link)
;; (straight-use-package 'magit)
;; (setq-default magit-diff-refine-hunk t)
;; (global-set-key (kbd "C-x g") 'magit-status)
;; (with-eval-after-load 'magit
;;   (fullframe magit-status magit-mode-quit-window))
;;

;; ;;; Folding
;; (straight-use-package 'origami)
;; (add-hook 'after-init-hook 'origami-mode)
;; (with-eval-after-load 'origami
;;   (define-key origami-mode-map (kbd "C-c f") 'origami-recursively-toggle-node)
;;   (define-key origami-mode-map (kbd "C-c F") 'origami-toggle-all-nodes))
;;
;; ;;; misc
;; (straight-use-package 'lua-mode)
;;
;; (straight-use-package 'uptimes)
;; (setq-default uptime-keep-count 200)
;; (add-hook 'after-init-hook (lambda () (require 'uptimes)))
;;
;; ;;; TReemacs & veterm
;; ;; cleanup later
;; (straight-use-package 'treemacs)
;; (straight-use-package 'lsp-treemacs)
;; (straight-use-package 'vterm)
;; (straight-use-package 'magit)
;; ;; Yasnippet
;; (straight-use-package 'yasnippet)
;;
;; (straight-use-package 'yasnippet-snippets)
;; (require 'yasnippet)
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)
;;
;; ;;; Access from emacsclient
;; (add-hook 'after-init-hook (lambda () (require 'server) (unless (server-running-p) (server-start))))
;;
;;
;; (provide 'init)
;;
;; ;;; init.el ends here
;;
