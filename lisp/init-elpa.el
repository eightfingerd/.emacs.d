
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

(eval-when-compile
  (require 'use-package))

(provide 'init-elpa)
