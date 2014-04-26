
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-gnome2 ()
  "Wheat on darkslategrey scheme.
`color-theme-gnome' started it all.

This theme supports standard faces, font-lock, eshell, info, message,
gnus, custom, widget, woman, diary, cperl, bbdb, and erc.  This theme
includes faces for Emacs and XEmacs.

The theme does not support w3 faces because w3 faces can be controlled
by your default style sheet.

This is what you should put in your .Xdefaults file, if you want to
change the colors of the menus in Emacs 20 as well:

emacs*Background:		DarkSlateGray
emacs*Foreground:		Wheat"
  (interactive)
  (color-theme-blue-gnus)
  (let ((color-theme-is-cumulative t))
    (color-theme-blue-erc)
    (color-theme-blue-eshell)
    (color-theme-salmon-font-lock)
    (color-theme-salmon-diff)
    (color-theme-install
     '(color-theme-gnome2
       ((foreground-color . "wheat")
	(background-color . "darkslategrey")
	(mouse-color . "Grey")
	(cursor-color . "LightGray")
	(border-color . "black")
	(background-mode . dark))
       ((apropos-keybinding-face . underline)
	(apropos-label-face . italic)
	(apropos-match-face . secondary-selection)
	(apropos-property-face . bold-italic)
	(apropos-symbol-face . info-xref)
	(goto-address-mail-face . message-header-to-face)
	(goto-address-mail-mouse-face . secondary-selection)
	(goto-address-url-face . info-xref)
	(goto-address-url-mouse-face . highlight)
	(list-matching-lines-face . bold)
	(view-highlight-face . highlight))
       (default ((t (nil))))
       (bbdb-company ((t (:foreground "pale green"))))
       (bbdb-name ((t (:bold t :foreground "pale green"))))
       (bbdb-field-name ((t (:foreground "medium sea green"))))
       (bbdb-field-value ((t (:foreground "dark sea green"))))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t :foreground "beige"))))
       (calendar-today-face ((t (:underline t))))
       (comint-highlight-prompt ((t (:foreground "medium aquamarine"))))
       (cperl-array-face ((t (:foreground "Yellow"))))
       (cperl-hash-face ((t (:foreground "White"))))
       (cperl-nonoverridable-face ((t (:foreground "SkyBlue"))))
       (custom-button-face ((t (:underline t :foreground "MediumSlateBlue"))))
       (custom-documentation-face ((t (:foreground "Grey"))))
       (custom-group-tag-face ((t (:foreground "MediumAquamarine"))))
       (custom-state-face ((t (:foreground "LightSalmon"))))
       (custom-variable-tag-face ((t (:foreground "Aquamarine"))))
       (diary-face ((t (:foreground "IndianRed"))))
       (dired-face-directory ((t (:bold t :foreground "sky blue"))))
       (dired-face-permissions ((t (:foreground "aquamarine"))))
       (dired-face-flagged ((t (:foreground "tomato"))))
       (dired-face-marked ((t (:foreground "light salmon"))))
       (dired-face-executable ((t (:foreground "green yellow"))))
       (fringe ((t (:background "darkslategrey"))))
       (highlight ((t (:background "PaleGreen" :foreground "DarkGreen"))))
       (highline-face ((t (:background "SeaGreen"))))
       (holiday-face ((t (:background "DimGray"))))
       (hyper-apropos-hyperlink ((t (:bold t :foreground "DodgerBlue1"))))
       (hyper-apropos-documentation ((t (:foreground "LightSalmon"))))
       (info-header-xref ((t (:foreground "DodgerBlue1" :bold t))))
       (info-menu-5 ((t (:underline t))))
       (info-node ((t (:underline t :bold t :foreground "DodgerBlue1"))))
       (info-xref ((t (:bold t :foreground "DodgerBlue1"))))
       (isearch ((t (:background "sea green"))))
       (italic ((t (:italic t))))
       (menu ((t (:foreground "wheat" :background "darkslategrey"))))
       (modeline ((t (:background "dark olive green" :foreground "wheat"))))
       (modeline-buffer-id ((t (:background "dark olive green" :foreground "beige"))))
       (modeline-mousable ((t (:background "dark olive green" :foreground "yellow green"))))
       (modeline-mousable-minor-mode ((t (:background "dark olive green" :foreground "wheat"))))
       (region ((t (:background "dark cyan" :foreground "cyan"))))
       (secondary-selection ((t (:background "Aquamarine" :foreground "SlateBlue"))))
       (show-paren-match-face ((t (:bold t :background "Aquamarine" :foreground "steel blue"))))
       (show-paren-mismatch-face ((t (:background "Red" :foreground "White"))))
       (underline ((t (:underline t))))
       (widget-field-face ((t (:foreground "LightBlue"))))
       (widget-inactive-face ((t (:foreground "DimGray"))))
       (widget-single-line-field-face ((t (:foreground "LightBlue"))))
       (w3m-anchor-face ((t (:bold t :foreground "DodgerBlue1"))))
       (w3m-arrived-anchor-face ((t (:bold t :foreground "DodgerBlue3"))))
       (w3m-header-line-location-title-face ((t (:foreground "beige" :background "dark olive green"))))
       (w3m-header-line-location-content-face ((t (:foreground "wheat" :background "dark olive green"))))
       (woman-bold-face ((t (:bold t))))
       (woman-italic-face ((t (:foreground "beige"))))
       (woman-unknown-face ((t (:foreground "LightSalmon"))))
       (zmacs-region ((t (:background "dark cyan" :foreground "cyan"))))))))
