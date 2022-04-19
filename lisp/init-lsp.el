;;; init-lsp --- LSP stuff
;;; Commentary:
;;; Code:
(when (maybe-require-package 'lsp-mode)
  (message "lsp loaded")
  (setq lsp-enable-file-watchers nil)
  (add-hook 'php-mode-hook #'lsp-deferred))

(when (maybe-require-package 'dap-mode)
  (setq dap-auto-configure-features '(sessions locals breakpoints expressions controls tooltip))
  (dap-mode 1)
  (require 'dap-php))

(provide 'init-lsp)
;;; init-lsp.el ends here
