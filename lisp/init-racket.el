;;; init-racket.el --- Basic support for programming in Racket -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'geiser)
(require-package 'geiser-racket)
(setq geiser-active-implementations '(racket))

(require-package 'paredit)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'geiser-repl-mode-hook 'enable-paredit-mode)

(setq-default scheme-program-name "racket")

;; Auto-start Geiser when opening a .scm file (optional but helpful)
(add-hook 'scheme-mode-hook 'geiser-mode)

;; Use Rainbow Delimiters to keep track of nested parens
(require-package 'rainbow-delimiters)
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)

(setq geiser-racket--parameters-extra '())

(defun geiser-racket--parameters ()
  "Return a list with all parameters needed to start racket.
This function uses `geiser-racket-init-file' if it exists."
  (let ((init-file (and (stringp geiser-racket-init-file)
                        (expand-file-name geiser-racket-init-file)))
        (binary (geiser-racket--real-binary))
        (rackdir geiser-racket-scheme-dir))
    `("-i" "-q" ,@geiser-racket--parameters-extra "-S" ,rackdir
      ,@(apply 'append (mapcar (lambda (p) (list "-S" p))
                               geiser-racket-collects))
      ,@(and (listp binary) (cdr binary))
      ,@(and init-file (file-readable-p init-file) (list "-f" init-file))
      "-f" ,(expand-file-name "geiser/startup.rkt" rackdir))))

(provide 'init-racket)
;;; init-racket.el ends here
