
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-katester ()
  "Color theme by walterh@rocketmail.com, created 2001-12-12.
A pastelly-mac like color-theme."
  (interactive)
  (color-theme-standard)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-katester
       ((background-color . "ivory")
	(cursor-color . "slateblue")
	(foreground-color . "black")
	(mouse-color . "slateblue"))
       (default ((t ((:background "ivory" :foreground "black")))))
       (bold ((t (:bold t))))
       (font-lock-string-face ((t (:foreground "maroon"))))
       (font-lock-keyword-face ((t (:foreground "blue"))))
       (font-lock-constant-face ((t  (:foreground "darkblue"))))
       (font-lock-type-face ((t (:foreground "black"))))
       (font-lock-variable-name-face ((t (:foreground "black"))))
       (font-lock-function-name-face ((t (:bold t :underline t))))
       (font-lock-comment-face ((t (:background "seashell"))))
       (highlight ((t (:background "lavender"))))
       (italic ((t (:italic t))))
       (modeline ((t (:background "moccasin" :foreground "black"))))
       (region ((t (:background "lavender" ))))
       (underline ((t (:underline t))))))))
