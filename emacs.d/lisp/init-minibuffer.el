;;; init-minibuffer.el --- Config for minibuffer completion       -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


(when (maybe-require-package 'vertico)
  (add-hook 'after-init-hook 'vertico-mode)

  (when (maybe-require-package 'embark)
    (with-eval-after-load 'vertico
      (define-key vertico-map (kbd "M-o") 'embark-act)
      (define-key vertico-map (kbd "C-h B") 'embark-bindings)
      (define-key vertico-map (kbd "C-c C-o") 'embark-export)
      (define-key vertico-map (kbd "C-c C-c") 'embark-act)))

  (when (maybe-require-package 'consult)
    (defmacro sanityinc/no-consult-preview (&rest cmds)
      `(with-eval-after-load 'consult
         (consult-customize ,@cmds :preview-key "M-P")))

    (sanityinc/no-consult-preview
     consult-ripgrep
     consult-git-grep consult-grep
     consult-bookmark consult-recent-file consult-xref
     consult--source-recent-file consult--source-project-recent-file consult--source-bookmark)

    (when (and (executable-find "rg"))
      (defun sanityinc/consult-ripgrep-at-point (&optional dir initial)
        (interactive (list current-prefix-arg (when-let ((s (symbol-at-point)))
                                                (symbol-name s))))
        (consult-ripgrep dir initial))
      (sanityinc/no-consult-preview sanityinc/consult-ripgrep-at-point)
      (global-set-key (kbd "M-?") 'sanityinc/consult-ripgrep-at-point))

    (global-set-key [remap switch-to-buffer] 'consult-buffer)
    (global-set-key [remap switch-to-buffer-other-window] 'consult-buffer-other-window)
    (global-set-key [remap switch-to-buffer-other-frame] 'consult-buffer-other-frame)
    (global-set-key [remap goto-line] 'consult-goto-line)
    (global-set-key (kbd "M-g f")  'consult-flymake)
    (global-set-key (kbd "M-g e")  'consult-compile-error)
    (global-set-key [remap imenu] 'consult-imenu)
    (global-set-key (kbd "M-g I")  'consult-imenu-multi)
    (global-set-key (kbd "M-g l") 'consult-line)
    (global-set-key (kbd "M-g L") 'consult-line-multi)


    (when (maybe-require-package 'embark-consult)
      (with-eval-after-load 'embark
        (require 'embark-consult)
        (add-hook 'embark-collect-mode-hook 'embark-consult-preview-minor-mode)))))

(when (maybe-require-package 'marginalia)
  (add-hook 'after-init-hook 'marginalia-mode))


(provide 'init-minibuffer)
;;; init-minibuffer.el ends here
