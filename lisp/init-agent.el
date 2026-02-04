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

(provide 'init-agent)
;;; init-agent.el ends here
