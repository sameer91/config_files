;;; init.el Emacs config entry point.

;; startup

(setq package-enable-at-startup nil
      load-prefer-newer t
      inhibit-startup-screen t)

(add-hook 'after-init-hook #'(lambda()
			       (interactive)
			       (require 'server)
			       (or (server-running-p)
				   (server-start))))

;; straight+use-package
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq use-package-compute-statistics t)

;; reduce gc frequency, default gc every 0.75mb
(setq gc-cons-threshold (* 128 1024 1024)
      read-process-output-max (* 4 1024 1024)
      process-adaptive-read-buffering nil)

;; Native compilation
(if (and (fboundp 'native-comp-available-p)
	 (native-comp-available-p))
    (setq comp-deferred-compilation t
	  package-native-compile t
	  ;; do not steal focus while doing async compilation
	  warning-suppress-types '((comp)))
  (message "Native compilation not available, lsp performance will suffer"))

;; native json
(unless (functionp 'json-serialize)
  (message "Native JSON is not available, lsp performance will suffer"))

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
(setq dashboard-startup-banner 'logo)
;; Value can be:
;;   - 'official which displays the official emacs logo.
;;   - 'logo which displays an alternative emacs logo.
;;   - an integer which displays one of the text banners
;;     (see dashboard-banners-directory files).
;;   - a string that specifies a path for a custom banner
;;     currently supported types are gif/image/text/xbm.
;;   - a cons of 2 strings which specifies the path of an image to use
;;     and other path of a text file to use if image isn't supported.
;;     ("path/to/image/file/image.png" . "path/to/text/file/text.txt").

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
;; vertically center content
(setq dashboard-vertically-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents   . 5)
                        ;; (bookmarks . 5)
                        ;; (projects  . 5)
                        ;; (agenda    . 5)
                        (registers . 5)))
(setq dashboard-icon-type 'all-the-icons)  ; use `all-the-icons' package

(defvar emacs-dir (file-name-directory load-file-name)
  "Root dir for init.el")
(defvar my-config (expand-file-name "my" emacs-dir)
  "my configs")
(add-to-list 'load-path my-config)

(require 'my-theme)
(require 'my-dashboard)
(require 'my-ui)
(require 'my-packages)
(require 'my-prog)

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(global-display-line-numbers-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
