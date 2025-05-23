;;; init-org-brain.el --- Personal configuration
;;; Commentary:

;;; This knowledge repository is deprecated and should no longer be used
;;; other than for references

;;; Code:

;;; org-brain
(require-package 'use-package)
(require 'use-package)

(use-package org-brain :ensure t
  :init
  (setq org-brain-path "~/org/brain")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (bind-key "C-c b" 'org-brain-prefix-map org-mode-map)
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  (setq org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil))

(provide 'init-org-brain)
;;; init-org-brain.el ends here
