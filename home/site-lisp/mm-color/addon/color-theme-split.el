(defun mmemo-split-color-theme ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "The color theme functions" nil t)
    (forward-line)
    (beginning-of-line)
    (insert "\n;; Splitted to ct-**themename**.el\n")
    (let ((filename nil) (fname nil) (buf nil))
      (while (re-search-forward
              "(defun color-theme-\\([^ \n\r]+\\)\\( \\|$\\)" nil t)
        (setq fname
              (concat
               (buffer-substring-no-properties
                (match-beginning 1) (match-end 1))))
        (setq filename
              (expand-file-name
               (concat
                "ct-"
                fname
                ".el")))
        (mark-defun)
        (write-region
         (region-beginning) (region-end)
         filename)
        (delete-region (region-beginning) (region-end))
        (save-current-buffer
          (if (get-file-buffer filename)
              (setq buf (get-file-buffer filename))
            (setq buf (find-file-noselect filename)))
          (set-buffer buf)
          (goto-char (point-min))
          (insert "\n  (autoload 'color-theme-install \"color-theme\" \"color-theme\" t)\n\n")
          (save-buffer))
        (kill-buffer buf)
        (insert
         (concat
          "(autoload '"
          "color-theme-" fname " "
          "\"ct-" fname "\""
          "\"theme for color-theme.\" t)\n"))
        ))))
 
