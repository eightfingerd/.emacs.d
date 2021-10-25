;; git remote set-url origin git@github:your-user-name/your-repo.git

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; (require 'init-benchmarking) ;; Measure startup time ASAP
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-core)
(require 'init-elpa)
(require 'init-ui)
(require 'init-packages)

(when (file-exists-p custom-file)
  (load-file custom-file))
