;;; init-java.el 
;;; Commentary:
;;; Code:

(require-package 'use-package)
(require-package 'lsp-mode)
(require-package 'hydra)

;; not working:
;;(require-package 'treemacs)
;;(require-package 'company-lsp)

(require-package 'lsp-ui)
(use-package lsp-java :ensure t :after lsp
  :config (add-hook 'java-mode-hook 'lsp))

(use-package dap-mode
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package dap-java :after (lsp-java))
(use-package lsp-java-treemacs :after (treemacs))

(provide 'init-java)
;;; init-java.el ends here
