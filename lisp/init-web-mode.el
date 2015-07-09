;;; init-web-mode

;;; Commentary:
;;;   setup for web-mode

(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\.php\\'" . web-mode))

(provide 'init-web-mode)
