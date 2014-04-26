
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-salmon-diff ()
  "Salmon and aquamarine faces for diff and change-log modes.
This is intended for other color themes to use (eg. `color-theme-gnome2')."
  (color-theme-install
   '(color-theme-salmon-diff
     nil
     (change-log-acknowledgement-face ((t (:foreground "LightBlue"))))
     (change-log-conditionals-face ((t (:bold t :weight bold :foreground "Aquamarine"))))
     (change-log-date-face ((t (:foreground "LightSalmon"))))
     (change-log-email-face ((t (:bold t :weight bold :foreground "Aquamarine"))))
     (change-log-file-face ((t (:bold t :weight bold :foreground "Aquamarine"))))
     (change-log-function-face ((t (:bold t :weight bold :foreground "Aquamarine"))))
     (change-log-list-face ((t (:foreground "Salmon"))))
     (change-log-name-face ((t (:foreground "Aquamarine"))))
     (diff-added-face ((t (nil))))
     (diff-changed-face ((t (nil))))
     (diff-context-face ((t (:foreground "grey70"))))
     (diff-file-header-face ((t (:bold t))))
     (diff-function-face ((t (:foreground "grey70"))))
     (diff-header-face ((t (:foreground "light salmon"))))
     (diff-hunk-header-face ((t (:foreground "light salmon"))))
     (diff-index-face ((t (:bold t))))
     (diff-nonexistent-face ((t (:bold t))))
     (diff-removed-face ((t (nil))))
     (log-view-message-face ((t (:foreground "light salmon")))))))
