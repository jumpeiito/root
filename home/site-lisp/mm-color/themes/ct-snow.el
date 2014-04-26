
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-snow ()
  "Color theme by Nicolas Rist, created 2001-03-08.
Black on gainsboro.  In Emacs, the text background is a shade darker
than the frame background: Gainsboro instead of snow.  This makes the
structure of the text clearer without being too agressive on the eyes.
On XEmacs, this doesn't really work as the frame and the default face
allways use the same foreground and background colors.
The color theme includes gnus, message, font-lock, sgml, and speedbar."
  (interactive)
  (color-theme-install
   '(color-theme-snow
     ((background-color . "snow2")
      (background-mode . light)
      (border-color . "black")
      (cursor-color . "RoyalBlue2")
      (foreground-color . "black")
      (mouse-color . "black"))
     ((gnus-mouse-face . highlight)
      (list-matching-lines-face . bold)
      (view-highlight-face . highlight))
    (default ((t (:background "gainsboro" :foreground "dark slate gray"))))
    (bold ((t (:bold t))))
    (bold-italic ((t (:italic t :bold t))))
    (calendar-today-face ((t (:underline t))))
    (custom-button-face ((t (:background "gainsboro" :foreground "dark cyan"))))
    (custom-documentation-face ((t (:background "gainsboro"))))
    (diary-face ((t (:foreground "red"))))
    (fg:black ((t (:foreground "black"))))
    (font-lock-builtin-face ((t (:background "gainsboro" :foreground "medium orchid"))))
    (font-lock-comment-face ((t (:background "gainsboro" :foreground "SteelBlue3"))))
    (font-lock-constant-face ((t (:background "gainsboro" :foreground "orange3"))))
    (font-lock-function-name-face ((t (:background "gainsboro" :foreground "blue3"))))
    (font-lock-keyword-face ((t (:background "gainsboro" :foreground "red3"))))
    (font-lock-string-face ((t (:background "gainsboro" :foreground "SpringGreen3"))))
    (font-lock-type-face ((t (:background "gainsboro" :foreground "dark cyan"))))
    (font-lock-variable-name-face ((t (:background "gainsboro" :foreground "purple2"))))
    (font-lock-warning-face ((t (:bold t :background "gainsboro" :foreground "red"))))
    (gnus-group-mail-1-empty-face ((t (:foreground "DeepPink3"))))
    (gnus-group-mail-1-face ((t (:bold t :foreground "DeepPink3"))))
    (gnus-group-mail-2-empty-face ((t (:foreground "HotPink3"))))
    (gnus-group-mail-2-face ((t (:bold t :foreground "HotPink3"))))
    (gnus-group-mail-3-empty-face ((t (:foreground "magenta4"))))
    (gnus-group-mail-3-face ((t (:bold t :foreground "magenta4"))))
    (gnus-group-mail-low-empty-face ((t (:foreground "DeepPink4"))))
    (gnus-group-mail-low-face ((t (:bold t :foreground "DeepPink4"))))
    (gnus-group-news-1-empty-face ((t (:foreground "ForestGreen"))))
    (gnus-group-news-1-face ((t (:bold t :foreground "ForestGreen"))))
    (gnus-group-news-2-empty-face ((t (:foreground "CadetBlue4"))))
    (gnus-group-news-2-face ((t (:bold t :foreground "CadetBlue4"))))
    (gnus-group-news-3-empty-face ((t (nil))))
    (gnus-group-news-3-face ((t (:bold t))))
    (gnus-group-news-low-empty-face ((t (:foreground "DarkGreen"))))
    (gnus-group-news-low-face ((t (:bold t :foreground "DarkGreen"))))
    (gnus-splash-face ((t (:foreground "ForestGreen"))))
    (gnus-summary-cancelled-face ((t (:background "black" :foreground "yellow"))))
    (gnus-summary-high-ancient-face ((t (:bold t :foreground "RoyalBlue"))))
    (gnus-summary-high-read-face ((t (:bold t :foreground "DarkGreen"))))
    (gnus-summary-high-ticked-face ((t (:bold t :foreground "firebrick"))))
    (gnus-summary-high-unread-face ((t (:bold t))))
    (gnus-summary-low-ancient-face ((t (:italic t :foreground "RoyalBlue"))))
    (gnus-summary-low-read-face ((t (:italic t :foreground "DarkGreen"))))
    (gnus-summary-low-ticked-face ((t (:italic t :foreground "firebrick"))))
    (gnus-summary-low-unread-face ((t (:italic t))))
    (gnus-summary-normal-ancient-face ((t (:foreground "RoyalBlue"))))
    (gnus-summary-normal-read-face ((t (:foreground "DarkGreen"))))
    (gnus-summary-normal-ticked-face ((t (:foreground "firebrick"))))
    (gnus-summary-normal-unread-face ((t (nil))))
    (gnus-summary-selected-face ((t (:underline t))))
    (gui-button-face ((t (:foreground "light grey"))))
    (highlight ((t (:background "LightSteelBlue1"))))
    (holiday-face ((t (:background "pink"))))
    (ibuffer-marked-face ((t (:foreground "red"))))
    (italic ((t (:italic t))))
    (message-cited-text-face ((t (:foreground "red"))))
    (message-header-cc-face ((t (:foreground "MidnightBlue"))))
    (message-header-name-face ((t (:foreground "cornflower blue"))))
    (message-header-newsgroups-face ((t (:italic t :bold t :foreground "blue4"))))
    (message-header-other-face ((t (:foreground "steel blue"))))
    (message-header-subject-face ((t (:bold t :foreground "navy blue"))))
    (message-header-to-face ((t (:bold t :foreground "MidnightBlue"))))
    (message-header-xheader-face ((t (:foreground "blue"))))
    (message-separator-face ((t (:foreground "brown"))))
    (modeline ((t (:background "dark slate gray" :foreground "gainsboro"))))
    (modeline-buffer-id ((t (:background "dark slate gray" :foreground "gainsboro"))))
    (modeline-mousable ((t (:background "dark slate gray" :foreground "gainsboro"))))
    (modeline-mousable-minor-mode ((t (:background "dark slate gray" :foreground "gainsboro"))))
    (region ((t (:background "lavender"))))
    (secondary-selection ((t (:background "paleturquoise"))))
    (sgml-comment-face ((t (:foreground "dark green"))))
    (sgml-doctype-face ((t (:foreground "maroon"))))
    (sgml-end-tag-face ((t (:foreground "blue2"))))
    (sgml-entity-face ((t (:foreground "red2"))))
    (sgml-ignored-face ((t (:background "gray90" :foreground "maroon"))))
    (sgml-ms-end-face ((t (:foreground "maroon"))))
    (sgml-ms-start-face ((t (:foreground "maroon"))))
    (sgml-pi-face ((t (:foreground "maroon"))))
    (sgml-sgml-face ((t (:foreground "maroon"))))
    (sgml-short-ref-face ((t (:foreground "goldenrod"))))
    (sgml-start-tag-face ((t (:foreground "blue2"))))
    (show-paren-match-face ((t (:background "SlateGray1"))))
    (show-paren-mismatch-face ((t (:background "purple" :foreground "white"))))
    (speedbar-button-face ((t (:foreground "green4"))))
    (speedbar-directory-face ((t (:foreground "blue4"))))
    (speedbar-file-face ((t (:foreground "cyan4"))))
    (speedbar-highlight-face ((t (:background "dark turquoise" :foreground "white"))))
    (speedbar-selected-face ((t (:underline t :foreground "red"))))
    (speedbar-tag-face ((t (:foreground "brown"))))
    (underline ((t (:underline t)))))))
