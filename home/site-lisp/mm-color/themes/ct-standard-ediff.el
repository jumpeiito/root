
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-standard-ediff ()
  "Standard colors for ediff faces.
This is intended for other color themes to use
\(eg. `color-theme-goldenrod')."
  (color-theme-install
   '(color-theme-beige-diff
     nil
     (ediff-current-diff-face-A ((t (:background "pale green" :foreground "firebrick"))))
     (ediff-current-diff-face-Ancestor ((t (:background "VioletRed" :foreground "Black"))))
     (ediff-current-diff-face-B ((t (:background "Yellow" :foreground "DarkOrchid"))))
     (ediff-current-diff-face-C ((t (:background "Pink" :foreground "Navy"))))
     (ediff-even-diff-face-A ((t (:background "light grey" :foreground "Black"))))
     (ediff-even-diff-face-Ancestor ((t (:background "Grey" :foreground "White"))))
     (ediff-even-diff-face-B ((t (:background "Grey" :foreground "White"))))
     (ediff-even-diff-face-C ((t (:background "light grey" :foreground "Black"))))
     (ediff-fine-diff-face-A ((t (:background "sky blue" :foreground "Navy"))))
     (ediff-fine-diff-face-Ancestor ((t (:background "Green" :foreground "Black"))))
     (ediff-fine-diff-face-B ((t (:background "cyan" :foreground "Black"))))
     (ediff-fine-diff-face-C ((t (:background "Turquoise" :foreground "Black"))))
     (ediff-odd-diff-face-A ((t (:background "Grey" :foreground "White"))))
     (ediff-odd-diff-face-Ancestor ((t (:background "light grey" :foreground "Black"))))
     (ediff-odd-diff-face-B ((t (:background "light grey" :foreground "Black"))))
     (ediff-odd-diff-face-C ((t (:background "Grey" :foreground "White")))))))
