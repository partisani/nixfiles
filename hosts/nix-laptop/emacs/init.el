(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Ensure `use-package` installed and force `:ensure t`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package base16-theme
  :ensure t
  :config
  (require 'base16-autogen-theme "~/.config/emacs/base16-autogen-theme.el")
  (load-theme 'base16-autogen t))

;; Better minibuffer usage and posframes
(use-package ivy
  :ensure t
  :config
  (ivy-mode))

;; Ivy extension with better Ivy usage
(use-package counsel
  :ensure t
  :config
  (counsel-mode))

;; Help me find keybinds
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Yet another modal editing package
(use-package boon
  :ensure t
  :config
  (require 'boon-qwerty)
  (boon-mode))

;; I cannot code in some languages without LSP
;; Completions
(use-package company
  :ensure t
  :config
  (global-company-mode))

;; Syntax Checking
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Better UX for LSP
(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-code-actions t))

;; LSP
(use-package lsp-mode
  :ensure t
  :commands lsp)

;; Programming language support
(use-package rustic :ensure t)
(use-package nix-mode :ensure t)

;; Tabs absolutely SUCK
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Custom modeline
(setq-default mode-line-format
              '(
                "󰍜 "
                (:eval (boon-state-string))
                " %b "))

;; My own customization file
(load-file "~/.config/emacs/simple.el")

;; I hate customize, and backups...
(setq backup-inhibited t)
(setq auto-save-default nil)

(setq custom-file "~/.config/emacs/custom.el")
(load-file custom-file)
