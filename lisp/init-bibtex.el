;;; init-bibtex.el --- Personal configuration
;;; Commentary:
;;; Code:

(require-package 'helm-bibtex)
(require 'helm-bibtex)
(setq helm-bibtex-bibliography "~/org/gtd/notes/references.bib" ;; where your references are stored
      helm-bibtex-library-path "~/Documents/lib" ;; wnhere your pdfs etc are stored
      helm-bibtex-notes-path "~/org/gtd/notes/notes.org" ;; where your notes are stored
      bibtex-completion-bibliography "~/org/gtd/notes/references.bib" ;; writing completion
      bibtex-completion-notes-path "~/org/gtd/notes/notes.org")

(provide 'init-bibtex)
;;; init-bibtex.el ends here
