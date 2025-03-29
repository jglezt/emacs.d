;;; init-misc.el --- Miscellaneous config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Misc config - yet to be placed in separate files

(add-auto-mode 'tcl-mode "^Portfile\\'")

(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (fset 'yes-or-no-p 'y-or-n-p))

(add-hook 'prog-mode-hook 'goto-address-prog-mode)
(add-hook 'conf-mode-hook 'goto-address-prog-mode)
(setq goto-address-mail-face 'link)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'after-save-hook 'sanityinc/set-mode-for-new-scripts)

(defun sanityinc/set-mode-for-new-scripts ()
  "Invoke `normal-mode' if this file is a script and in `fundamental-mode'."
  (and
   (eq major-mode 'fundamental-mode)
   (>= (buffer-size) 2)
   (save-restriction
     (widen)
     (string= "#!" (buffer-substring (point-min) (+ 2 (point-min)))))
   (normal-mode)))


(when (maybe-require-package 'info-colors)
  (with-eval-after-load 'info
    (add-hook 'Info-selection-hook 'info-colors-fontify-node)))


;; Handle the prompt pattern for the 1password command-line interface
(with-eval-after-load 'comint
  (setq comint-password-prompt-regexp
        (concat
         comint-password-prompt-regexp
         "\\|^Please enter your password for user .*?:\\s *\\'")))



(when (maybe-require-package 'regex-tool)
  (setq-default regex-tool-backend 'perl))

(with-eval-after-load 're-builder
  ;; Support a slightly more idiomatic quit binding in re-builder
  (define-key reb-mode-map (kbd "C-c C-k") 'reb-quit))

(add-auto-mode 'conf-mode "^Procfile\\'")


;;; Undo tree
(require-package 'undo-tree)
(global-undo-tree-mode)

 ;;; pdf-tools
(require-package 'pdf-tools)
(setq pdf-misc-print-programm "/usr/bin/lpr"
      pdf-misc-print-programm-args (quote ("-o media=Letter" "-o fitplot")))

 ;;; Password store
(require-package 'password-store-otp)

 ;;; bongo
(require-package 'bongo)

;;; plantuml
(require-package 'plantuml-mode)
(require-package 'flycheck-plantuml)

(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup))
(setq org-plantuml-jar-path "/Users/javier_gonzalez4/plantuml.jar")

;;; sql
(require-package 'sqlup-mode)
(add-hook 'sql-mode-hook 'sqlup-mode)

;;; org-noter
(pdf-tools-install)

;;; eww
(setq browse-url-browser-function 'eww-browse-url)

;;; editorconfig
(require-package 'editorconfig)
(editorconfig-mode 1)

;;; org-kanban
(require-package 'org-kanban)
(require 'org-kanban)

;;; hackernews
(require-package 'hackernews)

;;; anki-editor
(require-package 'anki-editor)

(setq max-specpdl-size 13000)

(setq max-lisp-eval-depth 10000)

;;; Quick fix org mode

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (haskell . nil)
   (latex . t)
   (ocaml . nil)
   (octave . t)
   (plantuml . t)
   (python . t)
   (ruby . t)
   (screen . nil)
   (shell . t)
   (sql . t)
   (sqlite . t)
   (scheme . t)))

(setq org-babel-python-command "python3")

;;; epresent
(require-package 'epresent)
(require 'epresent)

;;; Magit configuration to use password store
(require 'auth-source-pass)
(auth-source-pass-enable)
(setq auth-sources '(password-store))
(add-hook 'magit-process-find-password-functions
          'magit-process-password-auth-source)


(setq python-interpreter python-shell-interpreter)

(require-package 'groovy-mode)

;;; Install kubernetes

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))


(add-to-list 'image-types 'svg)

;;; For Logstash configuration files
(require-package 'logstash-conf)
(require 'logstash-conf)

;;; Puppet master
(require-package 'puppet-mode)
(require 'puppet-mode)

(provide 'init-misc)
;;; init-misc.el ends here
