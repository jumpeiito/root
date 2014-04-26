
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-dark-info ()
  "Color theme for info, help and apropos faces.
This is intended for other color themes to use (eg. `color-theme-late-night')."
  (interactive)
  (color-theme-install
   '(color-theme-dark-info
     nil
     (info-header-node ((t (:foreground "#666"))))
     (info-header-xref ((t (:foreground "#666"))))
     (info-menu-5 ((t (:underline t))))
     (info-menu-header ((t (:bold t :foreground "#666"))))
     (info-node ((t (:bold t :foreground "#888"))))
     (info-xref ((t (:bold t :foreground "#777")))))))
