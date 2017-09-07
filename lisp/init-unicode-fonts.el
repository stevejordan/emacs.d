;;; init-unicode-fonts --- setup to get a nicer looking unicode setup
;;; Commentary:
;;; Code:
(require-package 'persistent-soft)

(when (maybe-require-package 'unicode-fonts)
  (unicode-fonts-setup))

(provide 'init-unicode-fonts)
;;; init-unicode-fonts.el ends here
