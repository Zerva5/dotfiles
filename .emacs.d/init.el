;; Init MELPA! pls no touch
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   '(company-elisp company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                   (company-dabbrev-code company-gtags company-etags company-keywords)
                   company-oddmuse company-dabbrev))
 '(custom-enabled-themes '(doom-one))
 '(custom-safe-themes
   '("2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "e1ecb0536abec692b5a5e845067d75273fe36f24d01210bf0aa5842f2a7e029f" default))
 '(display-line-numbers-type 'relative)
 '(flycheck-display-errors-delay 0.3)
 '(flycheck-stylelintrc "~/.stylelintrc.json")
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-echo-area-message "")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(package-selected-packages
   '(company doom-themes counsel swiper lsp-mode company-lsp elpy lsp-ivy lsp-ui lsp-java dap-mode treemacs flycheck lua-mode smooth-scroll rainbow-delimiters ess sr-speedbar company-auctex ivy use-package auctex))
 '(pixel-scroll-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "CYEL" :slant normal :weight normal :height 143 :width normal)))))

(defun toggle-flyspell-and-eval-buffer() "Toggle flyspell and if disabled, run 'eval-buffer'."
  (interactive)
  (if (bound-and-true-p flyspell-mode)
      (flyspell-mode 0)
    (flyspell-mode)
    (flyspell-buffer))
  )

;; Use-package install and startup

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; (use-package tex
;;   :ensure auctex
;;   :mode (("\\.tex$" . TeX-mode))
;;   )

;; (use-package org
;;   :mode (("\\.org$" . org-mode))
;;   :config
;;   (define-key org-mode-map (kbd "C-<tab>") nil)
;;   :bind (
;;          ("C-c l" . org-store-link)
;;          ("C-c a" . org-agenda)
;;          )
;; )

(use-package ivy
  :ensure t
  :config(ivy-mode 1)
  )

(use-package swiper
  :after (ivy)
  :ensure t
  :bind(
        ("C-s" . 'swiper)
        )
  )

(use-package counsel
  :after swiper
  :ensure t)

(use-package doom-themes
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :bind(
        ([C-tab] . 'treemacs)
        ("C-c t" . 'treemacs-switch-workspace)
        )
  )

(use-package company
  :ensure t
  
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  
  (company-tng-configure-default)
  )

(use-package lua-mode
  :ensure t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; (use-package company-auctex
;;   :after tex
;;   :config
;;   (company-auctex-init)
;;   )

;; (use-package ess
;;   :mode
;;   (("\\.R$" . R-mode))
;;   (("\\.r$" . R-mode))
;;   )

;; (use-package rainbow-delimiters
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;   )

;; (use-package smooth-scroll
;;   :config
;;   (smooth-scroll-mode 1)
;;   (setq smooth-scroll/vscroll-step-size 5)
;;   )

;; (use-package flyspell
;;   :ensure t
;;   :bind
;;   ("C-c s" . toggle-flyspell-and-eval-buffer)
;;   )

;; (use-package elpy
;;   :ensure t
;;   :defer t
;;   :init
;;   (advice-add 'python-mode :before 'elpy-enable))

;; (use-package lsp-mode
;;   :ensure t
;;   )
  

;; (use-package lsp-java
;;   :ensure t
;;   :after lsp-mode
;;   :config
;;   (add-hook 'java-mode-hook' #'lsp)
;;   )

;;                                         ;

;; (use-package lsp-ui
;;   :ensure t
;;   )

;; (use-package company-lsp
;;   :ensure t
;;   )


;; Non-package config

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

(global-set-key (kbd "C-c e") 'eval-buffer)

;; Make emacs use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Spell check config
;; (require 'flyspell)
;; (flyspell-mode +1)

;; (global-set-key (kbd "C-c s") 'flyspell-buffer)
