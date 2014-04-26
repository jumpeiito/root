
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-gray1 ()
  "Color theme by Paul Pulli, created 2001-10-19."
  (interactive)
  (color-theme-install
   '(color-theme-gray1
     ((background-color . "darkgray")
      (background-mode . light)
      (background-toolbar-color . "#949494949494")
      (border-color . "#000000000000")
      (bottom-toolbar-shadow-color . "#595959595959")
      (cursor-color . "Yellow")
      (foreground-color . "black")
      (top-toolbar-shadow-color . "#b2b2b2b2b2b2"))
     nil
     (default ((t (nil))))
     (blue ((t (:foreground "blue"))))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (border-glyph ((t (nil))))
     (cperl-here-face ((t (:background "gray68" :foreground "DeepPink"))))
     (font-lock-builtin-face ((t (:bold t :foreground "red3"))))
     (font-lock-comment-face ((t (:foreground "gray50"))))
     (font-lock-constant-face ((t (:bold t :foreground "blue3"))))
     (font-lock-doc-string-face ((t (:foreground "black"))))
     (font-lock-function-name-face ((t (:bold t :foreground "DeepPink3"))))
     (font-lock-keyword-face ((t (:bold t :foreground "red"))))
     (font-lock-other-type-face ((t (:bold t :foreground "green4"))))
     (font-lock-preprocessor-face ((t (:bold t :foreground "blue3"))))
     (font-lock-reference-face ((t (:bold t :foreground "red3"))))
     (font-lock-string-face ((t (:foreground "red"))))
     (font-lock-type-face ((t (:bold t :foreground "white"))))
     (font-lock-variable-name-face ((t (:bold t :foreground "blue3"))))
     (font-lock-warning-face ((t (:bold t :foreground "Red"))))
     (green ((t (:foreground "green4"))))
     (gui-button-face ((t (:background "black" :foreground "red"))))
     (gui-element ((t (:background "gray58"))))
     (highlight ((t (:background "magenta" :foreground "yellow"))))
     (isearch ((t (:background "red" :foreground "yellow"))))
     (italic ((t (:italic t))))
     (left-margin ((t (nil))))
     (list-mode-item-selected ((t (:background "gray90" :foreground "purple"))))
     (m4-face ((t (:background "gray90" :foreground "orange3"))))
     (message-cited-text ((t (nil))))
     (message-header-contents ((t (nil))))
     (message-headers ((t (nil))))
     (message-highlighted-header-contents ((t (nil))))
     (modeline ((t (:background "#aa80aa" :foreground "White"))))
     (modeline-buffer-id ((t (:background "#aa80aa" :foreground "linen"))))
     (modeline-mousable ((t (:background "#aa80aa" :foreground "cyan"))))
     (modeline-mousable-minor-mode ((t (:background "#aa80aa" :foreground "yellow"))))
     (paren-blink-off ((t (:foreground "gray58"))))
     (paren-blink-on ((t (:foreground "purple"))))
     (paren-match ((t (:background "gray68" :foreground "white"))))
     (paren-mismatch ((t (:background "DeepPink" :foreground "black"))))
     (pointer ((t (nil))))
     (primary-selection ((t (:background "gray"))))
     (red ((t (:foreground "red"))))
     (right-margin ((t (nil))))
     (secondary-selection ((t (:background "paleturquoise"))))
     (text-cursor ((t (:background "Yellow" :foreground "darkgray"))))
     (toolbar ((t (:background "#aa80aa" :foreground "linen"))))
     (underline ((t (:underline t))))
     (vertical-divider ((t (nil))))
     (x-face ((t (:background "black" :foreground "lavenderblush"))))
     (yellow ((t (:foreground "yellow3"))))
     (zmacs-region ((t (:background "paleturquoise" :foreground "black")))))))
