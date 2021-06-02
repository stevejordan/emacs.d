;;; init-geben --- ensures geben is loaded and configured
;;; Commentary:
;;; Code:
(when (maybe-require-package 'geben)

  (defun steve-geben-release ()
    "Manually closesa ll geben connections. Useful when you get the
   unexpected 'Already in debugging' error."
    (interactive)
    (geben-stop)
    (dolist (session geben-sessions)
      (ignore-errors
        (geben-session-release session)))))

(provide 'init-geben)
;;; init-geben.el ends here
