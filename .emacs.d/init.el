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
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "6c386d159853b0ee6695b45e64f598ed45bd67c47f671f69100817d7db64724d" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "e1ecb0536abec692b5a5e845067d75273fe36f24d01210bf0aa5842f2a7e029f" default))
 '(display-line-numbers-type 'relative)
 '(flycheck-display-errors-delay 0.3)
 '(flycheck-stylelintrc "~/.stylelintrc.json")
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-echo-area-message "")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(package-selected-packages
   '(pyvenv lsp-pyright ccls racket-mode lsp-latex lsp-treemacs org-journal sml-mode markdown-mode company doom-themes counsel swiper lsp-mode company-lsp elpy lsp-ivy lsp-ui lsp-java dap-mode treemacs flycheck lua-mode smooth-scroll rainbow-delimiters ess sr-speedbar company-auctex ivy use-package auctex))
 '(pixel-scroll-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "BE5N" :slant normal :weight semi-bold :height 150 :width normal)))))

(defun toggle-flyspell-and-eval-buffer() "Toggle flyspell and if disabled, run 'eval-buffer'."
  (interactive)
  (if (bound-and-true-p flyspell-mode)
      (flyspell-mode 0)
    (flyspell-mode)
    (flyspell-buffer))
  )


(set-default 'truncate-lines nil)

;; Use-package install and startup

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t
        use-package-expand-minimally t))


;; (use-package tex
;;   :ensure auctex
;;   :mode (("\\.tex$" . TeX-mode))
;;   )

(use-package org
  :mode (("\\.org$" . org-mode))
  :config
  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil))) ;;truncation disabled
)

;; Completion framework (GENERALLY NOT IN BUFFER)
(use-package ivy
  :ensure t
  :config(ivy-mode 1)
  )

;; Search for ivy
(use-package swiper
  :after (ivy)
  :ensure t
  :bind(
        ("C-s" . 'swiper)
        )
  )

;; Provides useful commands that use ivy
(use-package counsel
  :after swiper
  :ensure t)

(use-package doom-themes
  :ensure t)

;; Tree based project viewer
(use-package treemacs
  :ensure t
  :defer t
;;  :config (setq treemacs-project-follow-mode t)
  :bind(
        ([C-tab] . 'treemacs)
        ("C-c t" . 'treemacs-switch-workspace)
        )
  )


;; In buffer completion framework
(use-package company
  :ensure t
  
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  
  (company-tng-configure-default)
  (global-set-key (kbd "<C-return>") 'company-complete)
  )


;; Syntax highlighting for lua
(use-package lua-mode
  :ensure t)

;; Syntax highlighting
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


(use-package sml-mode
  :ensure t)

;; (use-package company-auctex
;;   :after tex
;;   :config
;;   (company-auctex-init)
;;   )

;; Mode for R
(use-package ess
  :ensure t
  :mode
  (("\\.R$" . R-mode))
  (("\\.r$" . R-mode))
  )

;; Rainbows!
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )

;; (use-package smooth-scroll
;;   :config
;;   (smooth-scroll-mode 1)
;;   (setq smooth-scroll/vscroll-step-size 5)
;;   )

;; Spell check
(use-package flyspell
  :ensure t
  :mode (
;;    ("\\.org$" . flyspell-mode)
;;    ("\\.txt$" . flyspell-mode)
    ;("\\.$" . flyspell-mode)
    )
  :bind(
	("C-c s" . toggle-flyspell-and-eval-buffer)
	)
  )

;; C/C++ mode & code server
(use-package ccls
  :ensure t
  :bind (())
;;  :config
  ;; :hook ((c-mode c++-mode objc-mode cuda-mode) .
  ;;        (lambda () (require 'ccls) (lsp)))
  ;; (setq ccls-executable "/usr/local/bin/ccls")
  ;; (setq ccls-initialization-options
  ;;   '(:index (:comments 2) :completion (:detailedLabel t)))
  )


;; Debug server, not for one specific language
(use-package dap-mode
  :ensure t
  )

(setq lsp-ui-doc-mode nil)

;; Code completion. LSP: Languade Server Protocol
(use-package lsp-mode
  :ensure t
  :hook ((c-mode . lsp)
         (c++-mode . lsp)
         (java-mode . lsp)
         ;(lsp-mode . lsp-enable-which-key-integration))
         ))

;; LSP completion for these things:

(use-package lsp-treemacs
  :ensure t
  )

(use-package lsp-latex
  :ensure t
  )

(use-package lsp-java
  :ensure t
  )

;; Python 
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; Has high level UI modules for LSP
(use-package lsp-ui
  :ensure t
  :config(
    setq lsp-idle-delay 0.500

    )
  )

;;; So we can select python Venvs and lsp-pyright will pick it up
(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "~/.conda/envs")
  )


(use-package org-journal
  :ensure t)


;; Support for racket
(use-package racket-mode
  :ensure t)

(put 'test-case 'racket-indent-function 1)



;; Non-package config

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;; Journal Keybind
(global-set-key (kbd "C-c j") 'org-journal-new-date-entry)

;; Use some lsp-ui stuf instead of default lsp-mode
(define-key (current-global-map) [remap lsp-find-references] 'lsp-ui-peek-find-references)

;; Make emacs use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq visible-bell 1)

;; Stop emacs opening scratch when opening file
(setq inhibit-startup-screen t
      initial-buffer-choice  nil)

;; keybinds for C
(with-eval-after-load 'cc-mode
  (define-key c-mode-map (kbd "C-c c") 'compile)
    )

;; (with-eval-after-load 'emacs-lisp-mode
;;     (define-key emacs-lisp-mode-map (kbd "C-c e") upcase-region)
;;     (define-key emacs-lisp-mode-map (kbd "C-c b") eval-region)
;; )  

;; Change lsp-mode from Super-l to Cb-c C-l
(define-key lsp-mode-map (kbd "C-c C-l") lsp-command-map)
;; mode hooks for compilation

;; 
;; Default to truncating lines!
;;(set-default 'truncate-lines nilh)
;; Spell check config
;; (require 'flyspell)
;; (flyspell-mode +1)

;; (global-set-key (kbd "C-c s") 'flyspell-buffer)
