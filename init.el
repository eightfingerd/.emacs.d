;; git remote set-url origin git@github:your-user-name/your-repo.git

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))


;; Settings for package archives
(setq package-archives '(("emacs-china-gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("emacs-china-melpa" . "http://elpa.emacs-china.org/melpa/")
                         ("bfsu-melpa" . "http://mirrors.bfsu.edu.cn/elpa/melpa/")
                         ("bfsu-gnu" . "http://mirrors.bfsu.edu.cn/elpa/gnu/")
                         ("bfsu-org" . "http://mirrors.bfsu.edu.cn/elpa/org/")))
(setq package-check-signature nil)

(require 'package)

;; Initialize the packages, avoiding a re-initialization
(unless (bound-and-true-p package--initialized) ;; To avoid warnings on 27
  (setq package-enable-at-startup nil)
  (package-initialize))

(unless package-archive-contents
  (package-refresh-contents))

;; Settings for use-package package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Configure use-package prior to loading it
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-always-defer t
        use-package-always-demand nil
        use-package-expand-minimally t
        use-package-verbose t))
(setq load-prefer-newer t)

(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(eval-when-compile
  (require 'use-package))

;; Fullscreen by default, as early as possible
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (use-package doom-themes
  ;; :init
  ;; (load-theme 'doom-one))

;; Make M-x and other mini-buffers sortable, filterable
(use-package ivy
  :init
  (ivy-mode 1)
  (unbind-key "S-SPC" ivy-minibuffer-map)
  (setq ivy-height 15
        ivy-use-virtual-buffers t
        ivy-use-selectable-prompt t))

(use-package counsel
  :after ivy
  :init
  (counsel-mode 1)
  :bind (:map ivy-minibuffer-map))

;; Company is the best Emacs completion system.
(use-package company
  :bind (("C-." . company-complete))
  :custom
  (company-idle-delay 0) ;; I always want completion, give it to me asap
  (company-dabbrev-downcase nil "Don't downcase returned candidates.")
  (company-show-numbers t "Numbers are helpful.")
  (company-tooltip-limit 10 "The more the merrier.")
  :config
  (global-company-mode) ;; We want completion everywhere

  ;; use numbers 0-9 to select company completion candidates
  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x)
                        `(lambda () (interactive) (company-complete-number ,x))))
          (number-sequence 0 9))))

;; Flycheck is the newer version of flymake and is needed to make lsp-mode not freak out.
(use-package flycheck
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode) ;; always lint my code
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Package for interacting with language servers
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil ;; Flymake is outdated
        lsp-headerline-breadcrumb-mode nil)) ;; I don't like the symbols on the header a-la-vscode, remove this if you like them.

(use-package magit
  :config
  (magit-auto-revert-mode t) ;; Buffers will reload automatically if for example you hard-reset/revert changes in magit
  (setq magit-completing-read-function 'ivy-completing-read)) ;; Everything should work with Ivy

;; Opened file window manager
(use-package ace-window
  :bind
  ("M-o" . ace-window)
  :config
  (set-face-attribute 'aw-leading-char-face nil
                      :foreground "deep sky blue"
                      :weight 'bold
                      :height 2.0) ;; Some nice formatting to make the letters more visible
  (setq aw-scope 'frame)
  (setq aw-dispatch-always t)
  (setq aw-keys '(?q ?w ?e ?r ?a ?s ?d ?f))
  (setq aw-dispatch-alist '((?c aw-swap-window "Ace - Swap Window")
                            (?n aw-flip-window)))
  (ace-window-display-mode t))

;; Sort M-x by recently used, I can't believe this isn't a default already.
(use-package smex)

(use-package evil
  :init
  (evil-mode t))

