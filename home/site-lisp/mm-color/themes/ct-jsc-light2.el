
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-jsc-light2 ()
  "Color theme by John S Cooper, created 2001-10-29.
This builds on `color-theme-jsc-light'."
  (interactive)
  (color-theme-jsc-light)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-jsc-light2
       ((vc-annotate-very-old-color . "#0046FF")
	(senator-eldoc-use-color . t))
       nil
       (bold ((t (:bold t :weight bold))))
       (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
       (change-log-file-face ((t (:foreground "Blue"))))
       (change-log-name-face ((t (:foreground "Maroon"))))
       (comint-highlight-prompt ((t (:foreground "dark blue"))))
       (custom-button-face ((t (:background "lightgrey" :foreground "black" :box (:line-width 2 :style released-button)))))
       (custom-face-tag-face ((t (:bold t :family "helv" :weight bold :height 1.2))))
       (custom-group-tag-face ((t (:bold t :foreground "blue" :weight bold :height 1.2))))
       (custom-group-tag-face-1 ((t (:bold t :family "helv" :foreground "red" :weight bold :height 1.2))))
       (custom-variable-tag-face ((t (:bold t :family "helv" :foreground "blue" :weight bold :height 1.2))))
       (font-lock-constant-face ((t (:foreground "Maroon"))))
       (font-lock-function-name-face ((t (:foreground "Blue"))))
       (font-lock-type-face ((t (:italic t :foreground "Navy" :slant italic))))
       (fringe ((t (:background "grey88"))))
       (gnus-group-mail-1-empty-face ((t (:foreground "Blue2"))))
       (gnus-group-news-1-empty-face ((t (:foreground "ForestGreen"))))
       (gnus-group-news-1-face ((t (:bold t :foreground "ForestGreen" :weight bold))))
       (gnus-header-content-face ((t (:italic t :foreground "indianred4" :slant italic))))
       (gnus-header-name-face ((t (:bold t :foreground "maroon" :weight bold))))
       (gnus-header-subject-face ((t (:foreground "red4"))))
       (gnus-signature-face ((t (:italic t :slant italic))))
       (gnus-summary-high-read-face ((t (:bold t :foreground "DarkGreen" :weight bold))))
       (gnus-summary-high-unread-face ((t (:bold t :weight bold))))
       (gnus-summary-normal-read-face ((t (:foreground "DarkGreen"))))
       (gnus-summary-normal-ticked-face ((t (:foreground "Navy"))))
       (gnus-summary-normal-unread-face ((t (:bold t :foreground "DarkGreen" :weight bold))))
       (header-line ((t (:background "grey90" :foreground "grey20" :box nil))))
       (highlight ((t (:background "darkseagreen2"))))
       (ido-subdir-face ((t (:foreground "red"))))
       (isearch ((t (:background "magenta4" :foreground "lightskyblue1"))))
       (mode-line ((t (:background "grey88" :foreground "black" :box (:line-width -1 :style released-button)))))
       (region ((t (:background "lightgoldenrod2"))))
       (scroll-bar ((t (nil))))
       (secondary-selection ((t (:background "yellow"))))
       (show-paren-match-face ((t (:background "turquoise"))))
       (show-paren-mismatch-face ((t (:background "purple" :foreground "white"))))
       (tooltip ((t (:background "lightyellow" :foreground "black"))))))))