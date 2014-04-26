
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-feng-shui ()
  "Color theme by walterh@rocketmail.com (www.xanadb.com), created
  2003-10-16. Evolved from color-theme-katester"
  (interactive)
  (color-theme-install
   '(color-theme-feng-shui
     ((background-color . "ivory")
      (background-mode . light)
      (border-color . "black")
      (cursor-color . "slateblue")
      (foreground-color . "black")
      (mouse-color . "slateblue"))
     ((help-highlight-face . underline)
      (list-matching-lines-face . bold)
      (view-highlight-face . highlight)
      (widget-mouse-face . highlight))
     (default ((t (:stipple nil :background "ivory" :foreground "black"
:inverse-video nil :box nil :strike-through nil :overline nil
:underline nil :slant normal :weight normal :height 90 :width normal
:family "outline-courier new"))))
     (bold ((t (:bold t :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (border ((t (:background "black"))))
     (cursor ((t (:background "slateblue" :foreground "black"))))
     (fixed-pitch ((t (:family "courier"))))
     (font-lock-builtin-face ((t (:foreground "black"))))
     (font-lock-comment-face ((t (:italic t :background "seashell"
:slant italic))))
     (font-lock-constant-face ((t (:foreground "darkblue"))))
     (font-lock-doc-face ((t (:background "lemonChiffon"))))
     (font-lock-function-name-face ((t (:bold t :underline t :weight
bold))))
     (font-lock-keyword-face ((t (:foreground "blue"))))
     (font-lock-string-face ((t (:background "lemonChiffon"))))
     (font-lock-type-face ((t (:foreground "black"))))
     (font-lock-variable-name-face ((t (:foreground "black"))))
     (font-lock-warning-face ((t (:bold t :foreground "Red" :weight
bold))))
     (fringe ((t (:background "grey95"))))
     (header-line ((t (:bold t :weight bold :underline t :background
"grey90" :foreground "grey20" :box nil))))
     (highlight ((t (:background "mistyRose" :foreground "black"))))
     (isearch ((t (:background "magenta4" :foreground
"lightskyblue1"))))
     (isearch-lazy-highlight-face ((t (:background "paleturquoise"))))
     (italic ((t (:italic t :slant italic))))
     (menu ((t (nil))))
     (mode-line ((t (:bold t :background "mistyRose" :foreground "navy"
:underline t :weight bold))))
     (mouse ((t (:background "slateblue"))))
     (region ((t (:background "lavender" :foreground "black"))))
     (scroll-bar ((t (nil))))
     (secondary-selection ((t (:background "yellow"))))
     (tool-bar ((t (:background "grey75" :foreground "black" :box
(:line-width 1 :style released-button)))))
     (trailing-whitespace ((t (:background "red"))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "helv"))))
     (widget-button-face ((t (:bold t :weight bold))))
     (widget-button-pressed-face ((t (:foreground "red"))))
     (widget-documentation-face ((t (:foreground "dark green"))))
     (widget-field-face ((t (:background "gray85"))))
     (widget-inactive-face ((t (:foreground "dim gray"))))
     (widget-single-line-field-face ((t (:background "gray85")))))))
