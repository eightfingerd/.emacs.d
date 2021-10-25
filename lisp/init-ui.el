(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(global-hl-line-mode 1)
;; (set-face-background hl-line-face "#F2F2F2")
;; (set-face-underline-p 'highlight t)

;; Settings for highlight parentheses
(use-package highlight-parentheses
  :diminish
  :hook (prog-mode . highlight-parentheses-mode))

(use-package rainbow-delimiters
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

;; Indent grade guide line
(use-package indent-guide
  :hook (after-init . indent-guide-global-mode))

;; [built-in] paren mode
(use-package paren
  :ensure nil
  :config (show-paren-mode 1))

;; [built-in] electric-pair
(use-package electric
  :ensure nil
  :hook ((after-init . electric-indent-mode)
	     (prog-mode . electric-pair-mode)))

;; Beacon mode - highlight the line where your cursor is
(use-package beacon
  :unless *is-windows*
  :hook (after-init . beacon-mode))

;; Fullscreen by default, as early as possible
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (use-package doom-themes
  ;; :init
  ;; (load-theme 'doom-one))

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

(provide 'init-ui)
