
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-dark-font-lock ()
  "Color theme for font-lock faces only.
This is intended for other color themes to use (eg. `color-theme-late-night')."
  (interactive)
  (color-theme-install
   '(color-theme-dark-font-lock
     nil
     (font-lock-builtin-face ((t (:bold t :foreground "#777"))))
     (font-lock-comment-face ((t (:foreground "#555"))))
     (font-lock-constant-face ((t (:foreground "#777"))))
     (font-lock-doc-string-face ((t (:foreground "#777"))))
     (font-lock-doc-face ((t (:foreground "#777"))))
     (font-lock-function-name-face ((t (:bold t :foreground "#777"))))
     (font-lock-keyword-face ((t (:foreground "#777"))))
     (font-lock-preprocessor-face ((t (:foreground "#777"))))
     (font-lock-reference-face ((t (:foreground "#777"))))
     (font-lock-string-face ((t (:foreground "#777"))))
     (font-lock-type-face ((t (:bold t))))
     (font-lock-variable-name-face ((t (:bold t :foreground "#888"))))
     (font-lock-warning-face ((t (:bold t :foreground "#999")))))))
