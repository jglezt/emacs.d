;;; init-go.el --- Go editing -*- lexical-binding: t -*-
;;; Commentary:

;;; Eglot should handle the installation (NOT SUE ABOUT THIS STEP)
;;; https://github.com/golang/tools/tree/master/gopls

;;; Code:

(require-package 'go-mode)
(require 'go-mode)

(add-hook 'go-mode-hook 'eglot-ensure)

(provide 'init-go)
;;; init-go.el ends here
