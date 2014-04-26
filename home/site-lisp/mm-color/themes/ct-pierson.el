
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-pierson ()
  "Black on White color theme by Dan L. Pierson, created 2000-06-08.
Supports default faces, font-lock, show-paren."
  (interactive)
  (color-theme-install
   '(color-theme-pierson
     ((background-color . "AntiqueWhite")
      (background-mode . light)
      (border-color . "black")
      (cursor-color . "Orchid")
      (foreground-color . "black")
      (mouse-color . "Orchid"))
     ((list-matching-lines-face . bold))
    (default ((t (nil))))
    (bold ((t (:bold t))))
    (bold-italic ((t (:italic t :bold t))))
    (font-lock-builtin-face ((t (:foreground "Orchid"))))
    (font-lock-comment-face ((t (:foreground "ForestGreen"))))
    (font-lock-constant-face ((t (:foreground "CadetBlue"))))
    (font-lock-function-name-face ((t (:foreground "blue3"))))
    (font-lock-keyword-face ((t (:foreground "Blue"))))
    (font-lock-string-face ((t (:foreground "Firebrick"))))
    (font-lock-type-face ((t (:foreground "Purple"))))
    (font-lock-variable-name-face ((t (:foreground "blue3"))))
    (font-lock-warning-face ((t (:bold t :foreground "Red"))))
    (highlight ((t (:background "darkseagreen2"))))
    (italic ((t (:italic t))))
    (modeline ((t (:foreground "antiquewhite" :background "black"))))
    (modeline-mousable-minor-mode ((t (:foreground "antiquewhite" :background "black"))))
    (modeline-mousable ((t (:foreground "antiquewhite" :background "black"))))
    (modeline-buffer-id ((t (:foreground "antiquewhite" :background "black"))))
    (region ((t (:background "gray"))))
    (secondary-selection ((t (:background "paleturquoise"))))
    (show-paren-match-face ((t (:background "turquoise"))))
    (show-paren-mismatch-face ((t (:background "purple" :foreground "white"))))
    (underline ((t (:underline t)))))))