
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-beige-diff ()
  "Brownish faces for diff and change-log modes.
This is intended for other color themes to use (eg. `color-theme-gnome2'
and `color-theme-blue-sea')."
  (color-theme-install
   '(color-theme-beige-diff
     nil
     (change-log-acknowledgement-face ((t (:foreground "firebrick"))))
     (change-log-conditionals-face ((t (:foreground "khaki" :background "sienna"))))
     (change-log-date-face ((t (:foreground "gold"))))
     (change-log-email-face ((t (:foreground "khaki" :underline t))))
     (change-log-file-face ((t (:bold t :foreground "lemon chiffon"))))
     (change-log-function-face ((t (:foreground "khaki" :background "sienna"))))
     (change-log-list-face ((t (:foreground "wheat"))))
     (change-log-name-face ((t (:bold t :foreground "light goldenrod"))))
     (diff-added-face ((t (nil))))
     (diff-changed-face ((t (nil))))
     (diff-context-face ((t (:foreground "grey50"))))
     (diff-file-header-face ((t (:bold t :foreground "lemon chiffon"))))
     (diff-function-face ((t (:foreground "grey50"))))
     (diff-header-face ((t (:foreground "lemon chiffon"))))
     (diff-hunk-header-face ((t (:foreground "light goldenrod"))))
     (diff-index-face ((t (:bold t :underline t))))
     (diff-nonexistent-face ((t (:bold t :background "grey70" :weight bold))))
     (diff-removed-face ((t (nil))))
     (log-view-message-face ((t (:foreground "lemon chiffon")))))))
