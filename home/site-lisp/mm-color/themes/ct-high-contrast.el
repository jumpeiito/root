
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-high-contrast ()
  "High contrast color theme, maybe for the visually impaired.
Watch out!  This will set a very large font-size!

If you want to modify the font as well, you should customize variable
`color-theme-legal-frame-parameters' to \"\\(color\\|mode\\|font\\|height\\|width\\)$\".
The default setting will prevent color themes from installing specific
fonts."
  (interactive)
  (color-theme-standard)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-high-contrast
       ((cursor-color . "red")
	(width . 60)
	(height . 25)
	(background . dark))
       (default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight bold :height 240 :width normal :family "adobe-courier"))))

       (bold ((t (:bold t :underline t))))
       (bold-italic ((t (:bold t :underline t))))
       (font-lock-builtin-face ((t (:bold t :foreground "Red"))))
       (font-lock-comment-face ((t (:bold t :foreground "Firebrick"))))
       (font-lock-constant-face ((t (:bold t :underline t :foreground "Blue"))))
       (font-lock-function-name-face ((t (:bold t :foreground "Blue"))))
       (font-lock-keyword-face ((t (:bold t :foreground "Purple"))))
       (font-lock-string-face ((t (:bold t :foreground "DarkGreen"))))
       (font-lock-type-face ((t (:bold t :foreground "ForestGreen"))))
       (font-lock-variable-name-face ((t (:bold t :foreground "DarkGoldenrod"))))
       (font-lock-warning-face ((t (:bold t :foreground "Red"))))
       (highlight ((t (:background "black" :foreground "white" :bold 1))))
       (info-menu-5 ((t (:underline t :bold t))))
       (info-node ((t (:bold t))))
       (info-xref ((t (:bold t ))))
       (italic ((t (:bold t :underline t))))
       (modeline ((t (:background "black" :foreground "white" :bold 1))))
       (modeline-buffer-id ((t (:background "black" :foreground "white" :bold 1))))
       (modeline-mousable ((t (:background "black" :foreground "white" :bold 1))))
       (modeline-mousable-minor-mode ((t (:background "black" :foreground "white" :bold 1))))
       (region ((t (:background "black" :foreground "white" :bold 1))))
       (secondary-selection ((t (:background "black" :foreground "white" :bold 1))))
       (underline ((t (:bold t :underline t))))))))
