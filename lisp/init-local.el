;;; init-local --- steve's setup on top of purcells

;;; Commentary:
;;;   themes, bindings etc

;;; code:
(dark)

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
(require-package 'realgud)

(defun steve-set-line-length ()
  "Set line-length marker per major mode."
  (let ((steve-line-length 80))
    (when (equal major-mode 'python-mode)
      (setq steve-line-length 100))
    (when (equal major-mode 'php-mode)
      (setq steve-line-length 120))))

(defun steve-python-setup ()
  "Set python flychecker to be pylint."
  ;; (setq (make-local-variable flycheck-checker) 'python-pylint)
  (set (make-local-variable 'flycheck-flake8rc) "setup.cfg")
  (steve-set-line-length)
  )
(add-hook 'python-mode-hook 'steve-python-setup)

(require-package 'php-auto-yasnippets)

(defun parent-directory (dir)
  (unless (equal "/" dir)
    (file-name-directory (directory-file-name dir))))

(defun find-file-in-heirarchy (current-dir fname)
  "Search for a file named FNAME upwards through the directory
hierarchy, starting from CURRENT-DIR"
  (let ((file (concat current-dir fname))
        (parent (parent-directory (expand-file-name current-dir))))
    (if (file-exists-p file)
        file
      (when parent
        (find-file-in-heirarchy parent fname)))))

(defun find-composer ()
  (find-file-in-heirarchy
   (file-name-directory (buffer-file-name (current-buffer)))
   "composer.json"))

(defun php-autoload-location ()
  (let ((composer-json-location (find-composer)))
    (when composer-json-location
      (concat (file-name-directory composer-json-location) "vendor/autoload.php"))))

(defun steve-phpcs ()
  "Set PHP codesniffer standard to PSR2."
  ;; doesn't matter that this applies to all buffers
  (setq flycheck-phpcs-standard nil)
  (setq flycheck-php-phpcs-executable "~/bin/phpcs"))

(defun steve-php-yasnippet-init ()
  "Initialise yasnippet in php buffers."
  (yas-minor-mode)
  ;;(yas-reload-all)
  (setq ac-source-yasnippet nil)
  (define-key php-mode-map (kbd "C-c C-y") 'yas/create-php-snippet)
  (setq php-auto-yasnippet-required-files (list (php-autoload-location)))
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-c TAB") 'yas-expand)
  (define-key yas-minor-mode-map (kbd "C-c <tab>") 'yas-expand))

(defun steve-php-mode-setup ()
  "Functions to run on php-mode-hook."
  (steve-phpcs)
  (steve-set-line-length)
  (steve-php-yasnippet-init))

(defun steve-psr2-phpcs ()
  "Set PHP codesniffer standard to PSR2."
  ;; doesn't matter that this applies to all buffers
  (setq flycheck-phpcs-standard "PSR2"))

(defun steve-php-mode-setup ()
  "Functions to run on php-mode-hook."
  (with-eval-after-load 'company
    (sanityinc/local-push-company-backend 'company-gtags))
  (setq-local php-refactor-patch-command "patch -p1 --no-backup-if-mismatch --ignore-whitespace")
  (php-refactor-mode)
  (steve-psr2-phpcs))
(add-hook 'php-mode-hook 'steve-php-mode-setup)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(defun steve-yaml-init ()
  (setq yaml-indent-offset 4))
(add-hook 'yaml-mode-hook 'steve-yaml-init)

(setq preferred-javascript-indent-level 4)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Cycle between snake case, camel case, etc.
(require-package 'string-inflection)
(global-set-key (kbd "C-c C-c i") 'string-inflection-all-cycle)
(global-set-key (kbd "C-c C-c C") 'string-inflection-camelcase)        ;; Force to CamelCase
(global-set-key (kbd "C-c C-c L") 'string-inflection-lower-camelcase)  ;; Force to lowerCamelCase
(global-set-key (kbd "C-c C-c J") 'string-inflection-java-style-cycle) ;; Cycle through Java styles

(require-package 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :family "Consolas")
  (set-face-attribute 'default nil :height 150))

;; make ivy matching work like ido
(after-load 'init-ivy
  (sanityinc/enable-ivy-flx-matching))

;;(require 'init-pymacs)
(require 'init-geben)
(require 'init-web-mode)
(require 'init-gnu-global)
(require 'init-editorconfig)
(require 'init-handlebars)
(require 'init-twig)
(require 'init-org-confluence)
(require 'htmlr)
(require 'init-groovy)
(require 'init-yasnippet)
(require 'init-unicode-fonts)

(require-package 'php-refactor-mode)
(require-package 'scala-mode)

;;(require 'ob-scala)
;;(require 'flycheck-infer)

(provide 'init-local)
;;; init-local ends here
