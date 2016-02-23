(prefer-coding-system 'utf-8)
(add-to-list 'auto-coding-alist '(".*" . utf-8))
;;Theme and Other stuff
(setq inhibit-startup-screen t);; No splash scree
(package-initialize) ;; Initializing package manager
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized-master")
(load-theme 'solarized t)
(set-terminal-parameter nil 'background-mode 'dark)
(set-frame-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)
;; Stuff for GUI Emacs
(set-frame-font "Monaco")
(tool-bar-mode -1)
(setq ns-pop-up-frames nil)


;; Theme and Stuff end

;;Package Manager Code
(require 'package)
(add-to-list 'package-archives
			 '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
			 '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;; END packager manager code

;;IDO file management mode
;; Display ido results vertically, rather than horizontally
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
  (define-key ido-completion-map (kbd "<up>") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)
;;End

;;;End IDO mode

;;Ruby related Configs

;;Load Syntax Checker for ruby
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(require 'flymake-ruby)
  (add-hook 'ruby-mode-hook 'flymake-ruby-load)
;;End

(setq ruby-deep-indent-paren nil) ;Disable deep indentation for functions
(global-set-key (kbd "C-c r r") 'inf-ruby); Ruby Shell
(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby); setting the versions using rvm

(projectile-global-mode)
(add-hook 'ruby-mode-hook 'projectile-rails-on)
;(add-hook 'enh-ruby-mode-hook 'projectile-rails-on)
(add-hook 'projectile-mode-hook 'projectile-rails-on); Setting the minor mode to projectile mode when in a rails project
(add-hook 'ruby-mode-hook 'robe-mode);activate robe mode when in rubymode
;(add-hook 'enh-ruby-mode-hook 'robe-mode)
(setq projectile-enable-caching t)
;;Defining this again so that it excludes the files specified in the projectile file
(defun projectile-grep (&optional arg)
  "Perform rgrep in the project.

With a prefix ARG asks for files (globbing-aware) which to grep in.
With prefix ARG of `-' (such as `M--'), default the files (without prompt),
to `projectile-grep-default-files'."
  (interactive "P")
  (require 'grep) ;; for `rgrep'
  (let* ((roots (projectile-get-project-directories))
         (search-regexp (if (and transient-mark-mode mark-active)
                            (buffer-substring (region-beginning) (region-end))
                          (read-string (projectile-prepend-project-name "Grep for: ")
                                       (projectile-symbol-at-point))))
         (files (and arg (or (and (equal current-prefix-arg '-)
                                  (projectile-grep-default-files))
                             (read-string (projectile-prepend-project-name "Grep in: ")
                                          (projectile-grep-default-files))))))
    (dolist (root-dir roots)
      (require 'vc-git) ;; for `vc-git-grep'
      ;; in git projects users have the option to use `vc-git-grep' instead of `rgrep'
      (if (and (eq (projectile-project-vcs) 'git)
               projectile-use-git-grep
               (fboundp 'vc-git-grep))
          (vc-git-grep search-regexp (or files "") root-dir)
        ;; paths for find-grep should relative and without trailing /
        (let ((grep-find-ignored-directories
               (-union (--map (directory-file-name (file-relative-name it root-dir))
                              (cdr (projectile-ignored-directories)))
                       grep-find-ignored-directories))
              (grep-find-ignored-files
               (-union (-map (lambda (file)
                               (file-relative-name file root-dir))
                             (projectile-ignored-files))
                       grep-find-ignored-files)))

		  (grep-compute-defaults)
          (rgrep search-regexp (or files "* .*") root-dir))))))
;;end
;;autu triggering rvm-activate-corresponding-ruby
;;(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
;;    (rvm-activate-corresponding-ruby))


;;Indent Tabs
(setq php-mode-coding-style `WordPress)
;(setq ruby-indent-tabs-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ruby-mode yaml-mode web-mode scss-mode scala-mode2 rvm rspec-mode robe projectile-rails php-mode phi-search imenu-list go-mode git flymake-ruby flx-ido discover color-theme ac-emmet))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;test
;;PYTHON-DJANGO ENV
(require 'flycheck-pyflakes)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-to-list 'flycheck-disabled-checkers 'python-flake8)
