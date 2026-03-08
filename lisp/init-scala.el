;;; init-scala.el --- Scala support via eglot          -*- lexical-binding: t; -*-

;;; Commentary:
;;; Taken from https://olafurpg.github.io/metals/docs/editors/emacs.html#eglot
;;; The most common issue when compiling a new Scala library is the lack
;;; of compatibility with metals.  The most easy fix is to upgrade the used
;;; Scala version to the oldest one that metals can support.

;;; Code:

(require-package 'scala-mode)
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(scala-mode . ("metals" :initializationOptions
                               (:preferredBuildServer "gradle"
                                                      :enableSemanticHighlighting t)))))

(with-eval-after-load 'scala-mode
  (add-hook 'scala-mode-hook 'eglot-ensure))


(provide 'init-scala)
;;; init-scala.el ends here
