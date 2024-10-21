(require 'package)

;; I hate these
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode '(0 . 0))

;; Use line numbers in programming buffers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Internal border width = padding
(add-to-list 'default-frame-alist '(internal-border-width . 20))

;; Use headerline instead of modeline
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format '(""))

;; Make some gui elements look good
;; and simpler:
;; - Header line
;; - Line number indicator background
(let ((background (face-attribute 'default :background))
      (foreground (face-attribute 'default :foreground)))
  (set-face-attribute 'header-line nil
                      :height 100)
  (set-face-attribute 'mode-line nil
         	          :box `(:line-width 12 :color ,background)
	                  :underline nil ; foreground
	                  :height 10
	                  :background background)
  (set-face-attribute 'mode-line-inactive nil
	                  :height 10)
  (set-face-attribute 'line-number nil
                      :background background))

(setq x-underline-at-descent-line t)

;; More line spacing
(setq-default line-spacing 0.4)

;; Custom startup screen
(use-package enlight
  :config
  (setopt initial-buffer-choice #'enlight)
  :custom
  (enlight-content
   (enlight-menu
    '(("Quick Access"
       ("Nix configuration" (dired ".config/nix") "f"))
      ("Misc"
       ("Find files" find-file "F")
       ("New scratch buffer" scratch-buffer "b")
       ("Quit" kill-emacs "q"))))))

;; Floating minibuffer
(use-package mini-frame
  :ensure t
  :custom
  (mini-frame-show-parameters '((top . 15)
                                (width . 0.5)
                                (left . 0.5)
                                (alpha . 80)))
  (mini-frame-resize nil)
  :config
  (setq mini-frame-standalone nil)
  (mini-frame-mode))
