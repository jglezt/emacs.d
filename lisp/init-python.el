;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; See the following note about how I set up python + virtualenv to
;; work seamlessly with Emacs:
;; https://gist.github.com/purcell/81f76c50a42eee710dcfc9a14bfc7240

;;; Plus: Great article to initialize any virtualenv with lsp
;;; https://www.mattduck.com/lsp-python-getting-started.html

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(setq python-shell-interpreter "python3")

(require-package 'pip-requirements)

(when (maybe-require-package 'flymake-ruff)
  (defun sanityinc/flymake-ruff-maybe-enable ()
    (when (executable-find "ruff")
      (flymake-ruff-load)))
  (add-hook 'python-mode-hook 'sanityinc/flymake-ruff-maybe-enable))

(maybe-require-package 'ruff-format)
(reformatter-define ruff-fix
  :program ruff-format-command
  :args (list "check" "--fix-only" "--stdin-filename" (or (buffer-file-name) input-file))
  :lighter " RuffFix")

(when (maybe-require-package 'toml-mode)
  (add-to-list 'auto-mode-alist '("\\(poetry\\|uv\\)\\.lock\\'" . toml-mode)))

(when (maybe-require-package 'reformatter)
  (reformatter-define black :program "black" :args '("-")))

(with-eval-after-load 'project
  (add-to-list 'project-vc-extra-root-markers "pyproject.toml"))
(with-eval-after-load 'projectile
  (add-to-list 'projectile-project-root-files "pyproject.toml"))

;;; lsp-mode setup
(use-package lsp-mode
  :demand t
  :config
  (defun md/lsp-setup()
    ;; recommended by LSP docs for performance
    (setq read-process-output-max (* 1024 1024)) ;; 1mb

    (lsp-enable-imenu)
    (setq
     lsp-auto-configure t
     lsp-enable-dap-auto-configure nil ; Don't try to auto-enable dap: this creates a lot of binding clashes
     lsp-auto-guess-root t ; Uses projectile to guess the project root.
     lsp-before-save-edits t
     lsp-eldoc-enable-hover t
     lsp-eldoc-render-all nil
     lsp-completion-enable t
     lsp-completion-show-detail t
     lsp-completion-show-kind t
     lsp-enable-file-watchers t
     lsp-file-watch-threshold 100
     lsp-enable-folding t
     lsp-enable-imenu t
     lsp-enable-indentation t
     lsp-enable-links t
     lsp-enable-on-type-formatting nil
     lsp-enable-snippet nil ;; Not supported by company capf, which is the recommended company backend
     lsp-enable-symbol-highlighting nil
     lsp-enable-text-document-color nil
     lsp-enable-xref t
     lsp-flycheck-live-reporting nil
     lsp-idle-delay 0.5
     lsp-imenu-show-container-name t
     lsp-imenu-sort-methods '(position kind name)
     lsp-signature-auto-activate t
     lsp-signature-render-documentation t
     lsp-signature-doc-lines 10))
  :hook
  ((python-mode . lsp)))

(use-package lsp-ui
  :config (setq lsp-ui-sideline-show-hover t
                lsp-ui-sideline-delay 0.5
                lsp-ui-doc-delay 5
                lsp-ui-sideline-ignore-duplicates t
                lsp-ui-doc-position 'bottom
                lsp-ui-doc-alignment 'frame
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-use-childframe t)
  :commands lsp-ui-mode)

(provide 'init-python)
;;; init-python.el ends here
