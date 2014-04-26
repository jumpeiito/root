
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-black-on-gray ()
  "Color theme by sbhojwani, created 2002-04-03.
Includes ecb, font-lock, paren, semantic, and widget faces.
Some of the font-lock faces are disabled, ie. they look just
like the default face.  This is for people that don't like
the look of \"angry fruit salad\" when editing."
  (interactive)
  (color-theme-install
   '(color-theme-black-on-gray
     ((background-color . "white")
      (background-mode . light)
      (border-color . "blue")
      (foreground-color . "black"))
     ((buffers-tab-face . buffers-tab)
      (ecb-directories-general-face . ecb-default-general-face)
      (ecb-directory-face . ecb-default-highlight-face)
      (ecb-history-face . ecb-default-highlight-face)
      (ecb-history-general-face . ecb-default-general-face)
      (ecb-method-face . ecb-default-highlight-face)
      (ecb-methods-general-face . ecb-default-general-face)
      (ecb-source-face . ecb-default-highlight-face)
      (ecb-source-in-directories-buffer-face . ecb-source-in-directories-buffer-face)
      (ecb-sources-general-face . ecb-default-general-face)
      (ecb-token-header-face . ecb-token-header-face))
     (default ((t (nil))))
     (blue ((t (:foreground "blue"))))
     (bold ((t (:bold t :size "10pt"))))
     (bold-italic ((t (:italic t :bold t :size "10pt"))))
     (border-glyph ((t (:size "11pt"))))
     (buffers-tab ((t (:background "gray75"))))
     (display-time-mail-balloon-enhance-face ((t (:background "orange"))))
     (display-time-mail-balloon-gnus-group-face ((t (:foreground "blue"))))
     (display-time-time-balloon-face ((t (:foreground "red"))))
     (ecb-bucket-token-face ((t (:bold t :size "10pt"))))
     (ecb-default-general-face ((t (nil))))
     (ecb-default-highlight-face ((t (:background "cornflower blue" :foreground "yellow"))))
     (ecb-directories-general-face ((t (nil))))
     (ecb-directory-face ((t (:background "cornflower blue" :foreground "yellow"))))
     (ecb-history-face ((t (:background "cornflower blue" :foreground "yellow"))))
     (ecb-history-general-face ((t (nil))))
     (ecb-method-face ((t (:background "cornflower blue" :foreground "yellow"))))
     (ecb-methods-general-face ((t (nil))))
     (ecb-source-face ((t (:background "cornflower blue" :foreground "yellow"))))
     (ecb-source-in-directories-buffer-face ((t (:foreground "medium blue"))))
     (ecb-sources-general-face ((t (nil))))
     (ecb-token-header-face ((t (:background "SeaGreen1"))))
     (ecb-type-token-class-face ((t (:bold t :size "10pt"))))
     (ecb-type-token-enum-face ((t (:bold t :size "10pt"))))
     (ecb-type-token-group-face ((t (:bold t :size "10pt" :foreground "dimgray"))))
     (ecb-type-token-interface-face ((t (:bold t :size "10pt"))))
     (ecb-type-token-struct-face ((t (:bold t :size "10pt"))))
     (ecb-type-token-typedef-face ((t (:bold t :size "10pt"))))
     (font-lock-builtin-face ((t (:foreground "red3"))))
     (font-lock-constant-face ((t (:foreground "blue3"))))
     (font-lock-comment-face ((t (:foreground "blue"))))
     (font-lock-doc-face ((t (:foreground "green4"))))
     (font-lock-doc-string-face ((t (:foreground "green4"))))
     (font-lock-function-name-face ((t (nil))))
     (font-lock-keyword-face ((t (nil))))
     (font-lock-preprocessor-face ((t (:foreground "blue3"))))
     (font-lock-reference-face ((t (:foreground "red3"))))
     (font-lock-string-face ((t (nil))))
     (font-lock-type-face ((t (nil))))
     (font-lock-variable-name-face ((t (nil))))
     (font-lock-warning-face ((t (nil))))
     (green ((t (:foreground "green"))))
     (gui-button-face ((t (:background "grey75"))))
     (gui-element ((t (:size "8pt" :background "gray75"))))
     (highlight ((t (:background "darkseagreen2"))))
     (isearch ((t (:background "paleturquoise"))))
     (isearch-secondary ((t (:foreground "red3"))))
     (italic ((t (:size "10pt"))))
     (left-margin ((t (nil))))
     (list-mode-item-selected ((t (:background "gray68"))))
     (modeline ((t (:background "gray75"))))
     (modeline-buffer-id ((t (:background "gray75" :foreground "blue4"))))
     (modeline-mousable ((t (:background "gray75" :foreground "firebrick"))))
     (modeline-mousable-minor-mode ((t (:background "gray75" :foreground "green4"))))
     (paren-blink-off ((t (:foreground "gray"))))
     (paren-match ((t (:background "darkseagreen2"))))
     (paren-mismatch ((t (nil))))
     (pointer ((t (nil))))
     (primary-selection ((t (:background "gray65"))))
     (red ((t (:foreground "red"))))
     (region ((t (:background "gray65"))))
     (right-margin ((t (nil))))
     (secondary-selection ((t (:background "paleturquoise"))))
     (semantic-dirty-token-face ((t (nil))))
     (semantic-unmatched-syntax-face ((t (nil))))
     (text-cursor ((t (:background "red" :foreground "gray"))))
     (toolbar ((t (:background "gray75"))))
     (underline ((t (:underline t))))
     (vertical-divider ((t (:background "gray75"))))
     (widget ((t (:size "8pt" :background "gray75"))))
     (widget-button-face ((t (:bold t))))
     (widget-button-pressed-face ((t (:foreground "red"))))
     (widget-documentation-face ((t (:foreground "dark green"))))
     (widget-field-face ((t (:background "gray85"))))
     (widget-inactive-face ((t (nil))))
     (yellow ((t (:foreground "yellow"))))
     (zmacs-region ((t (:background "gray65")))))))