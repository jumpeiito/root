
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-wheat ()
  "Default colors on a wheat background.
Calls the standard color theme function `color-theme-standard' in order
to reset all faces."
  (interactive)
  (color-theme-standard)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-wheat
       ((background-color . "Wheat"))))))
