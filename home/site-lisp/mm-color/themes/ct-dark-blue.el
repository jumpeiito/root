
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-dark-blue ()
  "Color theme by Chris McMahan, created 2001-09-09.
Based on `color-theme-subtle-blue' with a slightly darker background."
  (interactive)
  (color-theme-subtle-blue)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-dark-blue
       ((background-color . "#537182")
	(foreground-color . "AntiqueWhite2"))
       nil
       (default ((t (nil))))
       (blank-space-face ((t (:background "LightGray"))))
       (blank-tab-face ((t (:background "Wheat" :foreground "DarkSlateGray"))))
       (cursor ((t (:background "LightGray"))))
       (dired-face-executable ((t (:foreground "green yellow"))))
       (dired-face-flagged ((t (:foreground "tomato"))))
       (dired-face-marked ((t (:foreground "light salmon"))))
       (dired-face-setuid ((t (:foreground "Red"))))
       (dired-face-socket ((t (:foreground "magenta"))))
       (fixed ((t (:bold t))))
       (font-lock-comment-face ((t (:italic t :foreground "Gray80"))))
       (font-lock-doc-face ((t (:bold t))))
       (font-lock-function-name-face ((t (:italic t :bold t :foreground "Yellow"))))
       (font-lock-string-face ((t (:italic t :foreground "DarkSeaGreen"))))
       (font-lock-type-face ((t (:bold t :foreground "YellowGreen"))))
       (gui-button-face ((t (:background "DarkSalmon" :foreground "white"))))
       (modeline ((t (:background "#c1ccd9" :foreground "#4f657d"))))
       (modeline-buffer-id ((t (:background "#c1ccd9" :foreground "#4f657d"))))
       (modeline-mousable ((t (:background "#c1ccd9" :foreground "#4f657d"))))
       (modeline-mousable-minor-mode ((t (:background "#c1ccd9" :foreground "#4f657d"))))
       (my-url-face ((t (:foreground "LightBlue"))))
       (region ((t (:background "PaleTurquoise4" :foreground "gray80"))))
       (secondary-selection ((t (:background "sea green" :foreground "yellow"))))
       (vm-header-content-face ((t (:italic t :foreground "wheat"))))
       (vm-header-from-face ((t (:italic t :foreground "wheat"))))
       (widget-button-pressed-face ((t (:foreground "red"))))
       (xref-keyword-face ((t (:foreground "blue"))))
       (zmacs-region ((t (:background "SlateGray"))))))))
