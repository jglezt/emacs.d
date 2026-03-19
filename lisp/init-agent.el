;;; init-agent.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; Requires agent installation before usage https://github.com/xenodium/agent-shell

(require-package 'agent-shell)
(use-package agent-shell
  :ensure t
  :config
  (setq agent-shell-anthropic-claude-environment
        (agent-shell-make-environment-variables :inherit-env t)))

;;; Manually installed through adding a git repository.
(require 'agent-review)

(use-package agent-shell-workspace
  :vc (:url "https://github.com/gveres/agent-shell-workspace")
  :ensure t
  :after agent-shell
  :bind (:map agent-shell-mode-map ("C-w" . agent-shell-workspace-toggle)))

(provide 'init-agent)
;;; init-agent.el ends here
