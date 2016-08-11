;;; init-gnu-global

;;; Commentary:
;;;   sets up funcs/hooks for gnu global

;;; code:

(require-package 'ggtags)

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update-single(filename)
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process
   "update-gtags" "update-gtags" "bash" "-c"
   (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))

(defun gtags-update-current-file()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))

(defun gtags-update-hook()
  "Update GTAGS file incrementally upon saving a file"
  (when (and (bound-and-true-p ggtags-mode) (or (featurep 'php-mode) (featurep 'java-mode)))
    (when (gtags-root-dir)
      (gtags-update-current-file))))

(defun steve-gnu-global-setup ()
  "setup gnu global auto updating, for attaching to mode hooks"
  (ggtags-mode))

(add-hook 'php-mode-hook 'steve-gnu-global-setup)
(add-hook 'java-mode-hook 'steve-gnu-global-setup)
(add-hook 'after-save-hook #'gtags-update-hook)

(provide 'init-gnu-global)
