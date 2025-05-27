;;; init-scala.el --- Scala support via eglot          -*- lexical-binding: t; -*-

;;; Commentary:
;;; Taken from https://olafurpg.github.io/metals/docs/editors/emacs.html#eglot

;;; Code:

(require-package 'scala-mode)
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")


(require-package 'sbt-mode)
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))


(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(scala-mode . ("metals-emacs"))))

(with-eval-after-load 'scala-mode
  (add-hook 'scala-mode-hook 'eglot-ensure))


(provide 'init-scala)
;;; init-scala.el ends here
