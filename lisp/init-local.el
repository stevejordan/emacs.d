;;; init-local --- steve's setup on top of purcells

;;; Commentary:
;;;   themes, bindings etc

;;; code:
(setq custom-enabled-themes '(tango-dark))
(global-linum-mode)
(menu-bar-mode -1)

;; set C-TAB to equal TAB
(global-set-key [C-tab] 'indent-for-tab-command)

;; C-x k to end emacsclient sessions
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

;; mail-mode for mutt messages
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(setq php-refactor-command "refactor")

(setq whitespace-style
      (quote
       (tabs trailing space-before-tab newline indentation empty
             space-after-tab tab-mark face lines-tail)))
(global-whitespace-mode t)

(global-set-key "\C-ci" 'magit-status)
(fset 'align-on-equals
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 97 108 105 103 110 45 tab 114 tab return 61 return] 0 "%d")) arg)))
(global-set-key "\C-x=" 'align-on-equals)

(require-package 'visual-regexp)
(require-package 'ack)

(defun steve-set-line-length ()
  "Find the line length setting from python flake8 config."
  (let ((steve-line-length 80))
    (when (equal major-mode 'python-mode)
      (setq steve-line-length 100))
    (set (make-local-variable 'whitespace-line-column) steve-line-length)))

(defun steve-python-setup ()
  "Set python flychecker to be pylint."
  ;; (setq (make-local-variable flycheck-checker) 'python-pylint)
  (set (make-local-variable 'flycheck-flake8rc) "setup.cfg")
  (steve-set-line-length)
  )
(add-hook 'python-mode-hook 'steve-python-setup)

(defun steve-psr2-phpcs ()
  "Set PHP codesniffer standard to PSR2."
  ;; doesn't matter that this applies to all buffers
  (setq flycheck-phpcs-standard "PSR2"))

(defun steve-php-mode-setup ()
  "Functions to run on php-mode-hook."
  (steve-psr2-phpcs))
(add-hook 'php-mode-hook 'steve-php-mode-setup)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(require 'init-pymacs)
(require 'init-geben)
(require 'init-web-mode)
(require 'init-gnu-global)
(require 'init-editorconfig)

(provide 'init-local)
;;; init-local ends here
