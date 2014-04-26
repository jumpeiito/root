(defvar org-directory "f:/Org/")

(defun org-rewrite-basename ()
  (let* ((dctime (decode-time (current-time)))
	 (year   (sixth dctime))
	 (month  (fifth dctime)))
    (format "%d%02d.org" year month)))

(defun org-rewrite-name ()
  (format "%s%s" org-directory (org-rewrite-basename)))

(defun org-rewrite-switch-to-buffer ()
  ;; (let* ((orgfile (org-rewrite-name))
  ;; 	 (buf     (get-buffer orgfile)))
  ;;   (unless (buffer-live-p buf)
  ;;     (generate-new-buffer orgfile))
  ;;   (switch-to-buffer buf))
  (let ((orgfile (org-rewrite-name)))
    (unless (get-buffer orgfile)
      (generate-new-buffer orgfile))
    (let ((buf (get-buffer orgfile)))
      (switch-to-buffer buf))))

(org-rewrite-switch-to-buffer)
