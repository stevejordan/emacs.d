;;; init-pymacs --- inits pymacs

(add-to-list 'load-path "~/.emacs.d/site-lisp/pymacs")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

(require 'pymacs)
(defun load-pymacs ()
  "perform pymacs load"
  (pymacs-load "ropemacs" "rope-"))

(load-pymacs)

(defun rope-before-save-actions ()
  ;; Does nothing but save us from an error.
  )
(defun rope-after-save-actions ()
  ;; Does nothing but save us from an error.
  )
(defun rope-exiting-actions ()
  ;; Does nothing but save us from an error.
  )

(defun pymacs-reload-rope ()
  "Reload rope"
  (interactive)
  (pymacs-terminate-services )
  (load-pymacs))

(defun my-pymacs-saver ()
  (if (equal (buffer-name) "*Pymacs*")
      (progn (message "NEVER kill *Pymacs*")
             nil)
    t))

(add-hook 'kill-buffer-query-functions 'my-pymacs-saver)

(provide 'init-pymacs)
;;; init-pymacs.el ends here
