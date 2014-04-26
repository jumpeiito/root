
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-salmon-font-lock ()
  "Color theme for font-lock faces only.
This is intended for other color themes to use (eg. `color-theme-gnome2')."
  (interactive)
  (color-theme-install
   '(color-theme-salmon-font-lock
     nil
     (font-lock-builtin-face ((t (:bold t :foreground "PaleGreen"))))
     (font-lock-comment-face ((t (:foreground "LightBlue"))))
     (font-lock-constant-face ((t (:foreground "Aquamarine"))))
     (font-lock-doc-string-face ((t (:foreground "LightSalmon"))))
     (font-lock-function-name-face ((t (:bold t :foreground "Aquamarine"))))
     (font-lock-keyword-face ((t (:foreground "Salmon"))))
     (font-lock-preprocessor-face ((t (:foreground "Salmon"))))
     (font-lock-reference-face ((t (:foreground "pale green"))))
     (font-lock-string-face ((t (:foreground "LightSalmon"))))
     (font-lock-type-face ((t (:bold t :foreground "YellowGreen"))))
     (font-lock-variable-name-face ((t (:bold t :foreground "Aquamarine"))))
     (font-lock-warning-face ((t (:bold t :foreground "red")))))))
