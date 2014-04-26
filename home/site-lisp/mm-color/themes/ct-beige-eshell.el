
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-beige-eshell ()
  "Brownish colors for eshell faces only.
This is intended for other color themes to use (eg. `color-theme-goldenrod')."
  (color-theme-install
   '(color-theme-beige-eshell
     nil
     (eshell-ls-archive-face ((t (:bold t :foreground "IndianRed"))))
     (eshell-ls-backup-face ((t (:foreground "Grey"))))
     (eshell-ls-clutter-face ((t (:foreground "DimGray"))))
     (eshell-ls-directory-face ((t (:bold t :foreground "dark khaki"))))
     (eshell-ls-executable-face ((t (:foreground "Coral"))))
     (eshell-ls-missing-face ((t (:foreground "black"))))
     (eshell-ls-picture-face ((t (:foreground "gold")))) ; non-standard face
     (eshell-ls-product-face ((t (:foreground "dark sea green"))))
     (eshell-ls-readonly-face ((t (:foreground "light steel blue"))))
     (eshell-ls-special-face ((t (:foreground "gold"))))
     (eshell-ls-symlink-face ((t (:foreground "peach puff"))))
     (eshell-ls-text-face ((t (:foreground "moccasin")))) ; non-standard face
     (eshell-ls-todo-face ((t (:bold t :foreground "yellow green")))) ; non-standard face
     (eshell-ls-unreadable-face ((t (:foreground "DimGray"))))
     (eshell-prompt-face ((t (:foreground "lemon chiffon")))))))
