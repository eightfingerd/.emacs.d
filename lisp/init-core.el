(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))

;; (setq backup-directory-alist (quote (("." . "~/.backups"))))
;; Settings for backup files
(setq make-backup-files nil
      auto-save-default nil)

(if *is-mac*
    (setq delete-by-moving-to-trash t))

(fset 'yes-or-no-p 'y-or-n-p)

(provide 'init-core)
