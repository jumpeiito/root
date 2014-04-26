;;; default.el --- load auto-autoload.el

;;; Copyright (C) 2002-2005 The Meadow Team

;; Author: KOSEKI Yoshinori <kose@meadowy.org>
;; Keywords: elisp

;;; Commentary:

;; Emacs Lisp Packages for Meadow.

;; If you don't want to load this file, set ~/.emacs.
;; (setq inhibit-default-init t)

;;; Code:

;;; Meadow/packages
;;; emacs/packages


(setq netinstall-pkg-dir (expand-file-name (concat data-directory 
                                                   "c:/tex/meadow/packages")))
(unless (file-exists-p netinstall-pkg-dir)
  (setq netinstall-pkg-dir (expand-file-name (concat data-directory 
                                                     "../../packages")))
  (unless (file-exists-p netinstall-pkg-dir)
    (setq netinstall-pkg-dir nil)))
    
;; When Meadow/packages/pkginfo/***/auto-autoloads.el exists, load it.
(let* ((dir (expand-file-name "pkginfo" netinstall-pkg-dir))
       (dirs (directory-files dir))
      el)
  (while dirs
    (setq el (concat dir "/" (car dirs) "/auto-autoloads.el"))
    (if (file-exists-p el)
        ;;(load-file el))
        (load el t t))
    (setq dirs (cdr dirs))))

;; add Netinstalled info path ($MEADOW/info)
(defadvice info-initialize
  (after info-initialize-after activate)
  "add directory `$MEADOW/info' to Info-directory-list." 
  (let ((dir (expand-file-name "info" netinstall-pkg-dir)))
    (unless (member dir Info-directory-list)
      (setq Info-directory-list (append (list dir) Info-directory-list)))))

;;; default.el ends here
