;;; init-zig.el --- Support for the Zig language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Tree-sitter support for Zig ------------------------------------------------
(when (featurep 'treesit)                       ; Emacs 29+
  ;; Add upstream Zig grammar to `treesit-language-source-alist' if needed
  (add-to-list 'treesit-language-source-alist
               '(zig "https://github.com/GrayJack/tree-sitter-zig"))

  ;; Compile & install the grammar automatically the first time Emacs starts
  (unless (treesit-language-available-p 'zig)
    (treesit-install-language-grammar 'zig)))

;; Prefer `zig-ts-mode' when a grammar is present, otherwise fall back to
;; legacy `zig-mode'.
(if (and (maybe-require-package 'zig-ts-mode)
         (treesit-language-available-p 'zig))
    (progn
      (add-to-list 'auto-mode-alist '("\\.\\(zig\\|zon\\)\\'" . zig-ts-mode))
      (with-eval-after-load 'eglot
        (add-to-list 'eglot-server-programs '(zig-ts-mode . ("zls")))))
  (require-package 'zig-mode))

(provide 'init-zig)
;;; init-zig.el ends here
