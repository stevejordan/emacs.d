;;; init-local --- local options to add to upstream
;;; Commentary:
;;; Code:
(color-theme-sanityinc-solarized-dark)

;; set C-TAB to equal TAB
(global-set-key [C-tab] 'indent-for-tab-command)

;; default font
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :family "Fira Code")
  (set-face-attribute 'default nil :height 140))

(when(maybe-require-package 'fira-code-mode)
  (add-hook 'prog-mode 'fira-code-mode))

(with-eval-after-load 'vertico
  (add-to-list 'completion-styles 'flex))

(remove-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

(defun steve/font-size-change (size)
  "Change default font size to SIZE."
  (interactive "nSize (pt.): ")
  (set-face-attribute 'default nil :height size))

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))

(when (maybe-require-package 'neotree)
  (setq projectile-switch-project-action 'neotree-projectile-action))

(setq switch-to-buffer-obey-display-actions t)

(require 'init-lsp)

(setq org-agenda-files '("~/todo.org"))

;; (when (maybe-require-package 'ag)
;;   (add-to-list 'ag-arguments "-U"))

;; remove on update to 29
(add-to-list 'image-types 'svg)

(provide 'init-local)
;;; init-local ends here
