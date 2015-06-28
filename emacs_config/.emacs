;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;Shreyas's Emacs Configuration file

;;Imp work
(load-file "~/.emacs.d/init.elc")

;;Global Key settings
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "M-n") 'goto-line) ; Goto Line using Alt-n
(global-set-key (kbd "C-c c") 'comment-region) ;comment region 
(global-set-key (kbd "C-c u") 'uncomment-region) ;uncomment region 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 2)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(delete-selection-mode nil)
 '(fci-rule-color "#073642")
 '(fill-column 80)
 '(font-lock-maximum-size 512000)
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(package-selected-packages
   (quote
	(scala-mode2 enh-ruby-mode phi-search php-mode yaml-mode web-mode scss-mode rvm rspec-mode robe projectile-rails imenu-list go-mode flymake-ruby flx-ido discover color-theme ac-emmet)))
 '(paren-mode (quote paren) nil (paren))
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(tab-stop-list
   (quote
	(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96)))
 '(tab-width 4)
 '(transient-mark-mode t)
 '(user-mail-address "shreyas.ns@freshdesk.com")
 '(vc-follow-symlinks nil))
;end---

;Custom Font faces and styling
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:size "8pt" :family "Lucida Sans Typewriter"))))
 '(underline ((t (:background "pink" :underline nil))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "selectedKnobColor")))))
;end--

;; Auto-Complete

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'scss-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)
(setq web-mode-ac-sources-alist
	  '(("css" . (ac-source-css-property))
		("html" . (ac-source-words-in-buffer ac-source-abbrev))))
;;end------

;Commenting and Uncommenting regions
(global-set-key "\C-cc" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)

;;Auto Indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;;Create eshell at the bottom of the editor and bind it to F5 key
(fset 'create-eshell-at-bottom
   "\C-x2\C-xo\C-[xesh\C-i\C-m\C-xo\C-x^\C-x^\C-x^\C-x^\C-x^\C-x^\C-x^\C-x^")
(global-set-key (kbd "<f5>") 'create-eshell-at-bottom)
;;end------

;;Sets a save place
(require 'saveplace)                          ;; get the package
(setq-default save-place t)                   ;; activate it for all buffers
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean

(defadvice save-place-alist-to-file
  (around save-place-alist-to-file-force-print-length activate)
  (let ((print-level nil)
        (print-length nil))
    ad-do-it))
;; end set save place

;;webmodes
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; End of web mode

;;ruby mode key bindings
;; (eval-after-load "ruby-mode"
;;   '(define-key ruby-mode-map (kbd "C-M-e") 'ruby-end-of-defun))
;; (eval-after-load "ruby-mode"
;;   '(define-key ruby-mode-map (kbd "C-M-a") 'ruby-beginning-of-defun))

;;List and goto any function in the file
(defvar gotofunregex
  '((nil "^\\s-*\\(\\(def\\|class\\)\\s-+[-A-Za-z0-9_+]+\\)" 1)))

(defun display-func-imenu ()
  (interactive)
  (setq imenu-generic-expression gotofunregex)
  (setq-local imenu-create-index-function 'imenu-default-create-index-function))

(add-hook 'ruby-mode-hook 'display-func-imenu)
(imenu-list-minor-mode)
(global-set-key (kbd "M-g") 'imenu-list-show)
;;(add-hook 'imenu-list-minor-mode-hook lambda
;;end

(defun display-ansi-colors ()
  (interactive)
	(ansi-color-apply-on-region (point-min) (point-max)))
(put 'narrow-to-region 'disabled nil)

(set-frame-font "Monaco")
(require 'phi-search)
(global-set-key (kbd "C-s") 'phi-search)
(global-set-key (kbd "C-r") 'phi-search-backward)
