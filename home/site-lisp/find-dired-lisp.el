(require 'dired)
(require 'findr)

(defun mmemo-setup-dired-buffer (dir)
  (widen)
  (kill-all-local-variables)
  (setq buffer-read-only nil)
  (erase-buffer)
  (dired-mode dir (cdr find-ls-option))
  ;; This really should rerun the find command, but I don't
  ;; have time for that.
  (use-local-map (append (make-sparse-keymap)
                         (current-local-map)))
  (define-key (current-local-map) "g" 'undefined)
  (setq buffer-read-only nil)
  (mmemo-find-dired-set-variable dir)
  (insert "" (file-name-as-directory
              (expand-file-name dir)) ":\n")
  )

(defun mmemo-find-dired-set-variable (dir)
  (setq default-directory dir)
  (setq dired-directory dir)
  ;; Set subdir-alist so that Tree Dired will work:
  (if (fboundp 'dired-simple-subdir-alist)
      (dired-simple-subdir-alist)
    (set (make-local-variable 'dired-subdir-alist)
         (list (cons default-directory (point-min-marker)))))
  )

(fset 'find-name-dired-lisp 'find-dired-lisp)
(defun find-dired-lisp (direddir args)
  (interactive
   (list
    (read-file-name "Run find in directory: " nil "" t)
    (read-string "Run find (with regexp): ")))
  (or (file-directory-p direddir)
      (error "find-dired needs a directory: %s" direddir))
  (let* ((dirs
          (mapcar '(lambda (name)
                     (file-relative-name name direddir)
                     )
                  (findr args direddir)))
         (dir (abbreviate-file-name
               (file-name-as-directory
                (expand-file-name direddir))))
         (dirlist (cons dir dirs))
         )
  
    (let ((dired-buffers dired-buffers))
      (switch-to-buffer (get-buffer-create "*Find*"))
      (mmemo-setup-dired-buffer dir)
      ;;(insert "" args "\n")
      (insert
       (concat
        "find with " args "\n"))
      (dired-readin-insert dirlist)
      (indent-rigidly (point-min) (point-max) 2)
      (mmemo-find-dired-set-variable dir)
      ;;(setq mode-line-process '(":%s"))
      (goto-char (point-min))
      )))

(defun find-grep-dired-lisp (direddir regxp)
  (interactive
   (list
    (read-file-name "Run find in directory: " nil "" t)
    (read-string "Run Grep (with regexp): ")))
  (or (file-directory-p direddir)
      (error "find-dired needs a directory: %s" direddir))
  (let* ((greplist
          (mapcar '(lambda (name)
                     (file-relative-name name direddir)
                     )
                  (findr "." direddir)))
         (dirlist nil) ;;(cons direddir dirs))
         (dirs nil)
         (dir (abbreviate-file-name
               (file-name-as-directory
                (expand-file-name direddir))))
         (name nil)
         )

    (while greplist
      (setq name (expand-file-name
                  (car greplist) dir))
      (when (and
             name
             (not (file-directory-p name))
             (file-readable-p name))
        (message (format "Grep in %s ..."
                         (file-name-directory name)))
        (with-temp-buffer
          (condition-case err
              (insert-file-contents name)
            (error
             ()))
          (if (re-search-forward regxp nil t)
              (setq dirs (cons
                          (file-relative-name name dir)
                          dirs)))))
      (setq greplist (cdr greplist)))
    (message "Grep done!")
    (setq dirlist (cons dir dirs))
    (let ((dired-buffers dired-buffers))
      (switch-to-buffer
       (get-buffer-create "*Find-grep*"))
      (mmemo-setup-dired-buffer dir)
      ;;(insert " " regxp "\n")
      (insert
       (concat
        "find-grep: "
        regxp "\n"))
      (dired-readin-insert dirlist)
      (indent-rigidly (point-min) (point-max) 2)
      (mmemo-find-dired-set-variable dir)
      ;;(setq mode-line-process '(":%s"))
      (goto-char (point-min))
      )))

(provide 'find-dired-lisp)