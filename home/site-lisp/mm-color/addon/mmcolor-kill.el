(defun my-color-theme-print ()
  (let ((buf))
    (switch-to-buffer (get-buffer-create "*Color Theme*"))
    (unless buf
      (setq buffer-read-only nil)
      (erase-buffer))
    (insert
     (concat
      "("
      (format "%s" (nth 0 (car color-theme-history)))
      ")"))))

(defun my-kill-saves()
  (if (and theme-load-from-file
           (file-writable-p (concat (expand-file-name mmemo-theme-file))))
      (progn
        (my-color-theme-print)
        (write-file  (concat (expand-file-name mmemo-theme-file))))))

(my-kill-saves)