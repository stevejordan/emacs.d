;;; package --- Steve Local Settings

;;; Commentary:
;;; Local settings on top of purcell

;;; Code:
(require-package 'php-refactor-mode)
(require-package 'geben)
(require-package 'scala-mode)

(defun steve/php-mode-hook ()
  "My php-mode settings."
  (with-eval-after-load 'company
    (sanityinc/local-push-company-backend 'company-gtags))
  (setq-local php-refactor-patch-command "patch -p1 --no-backup-if-mismatch --ignore-whitespace")
  (php-refactor-mode))

(add-hook 'php-mode-hook 'steve/php-mode-hook)

;; dark theme
(dark)

;; set C-TAB to equal TAB
(global-set-key [C-tab] 'indent-for-tab-command)
(global-set-key (kbd "C-c i") 'magit-status)

(global-linum-mode)

;;(require 'ob-scala)
(require 'flycheck-infer)

(provide 'init-local)
;;; init-local ends here
