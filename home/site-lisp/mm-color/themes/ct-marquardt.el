
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-marquardt ()
  "Color theme by Colin Marquardt, created 2000-10-25.
Black on bisque, a light color. Based on some settings from Robin S. Socha.
Features some color changes to programming languages, especially vhdl-mode.
You might also want to put something like
   Emacs*Foreground:	       Black
   Emacs*Background:	       bisque2
in your ~/.Xdefaults."
  (interactive)
  (color-theme-install
   '(color-theme-marquardt
     ((background-color . "bisque")
      (background-mode . light)
      (background-toolbar-color . "bisque")
      (border-color . "#000000000000")
      (bottom-toolbar-shadow-color . "#909099999999")
      (cursor-color . "Red3")
      (foreground-color . "black")
      (top-toolbar-shadow-color . "#ffffffffffff"))
    (default ((t (nil))))
    (blue ((t (:foreground "blue"))))
    (bold ((t (:bold t))))
    (bold-italic ((t (:bold t))))
    (border-glyph ((t (nil))))
    (calendar-today-face ((t (:underline t))))
    (diary-face ((t (:foreground "red"))))
    (display-time-mail-balloon-enhance-face ((t (:background "orange"))))
    (display-time-mail-balloon-gnus-group-face ((t (:foreground "blue"))))
    (display-time-time-balloon-face ((t (:foreground "red"))))
    (ff-paths-non-existant-file-face ((t (:bold t :foreground "NavyBlue"))))
    (font-lock-comment-face ((t (:foreground "gray50"))))
    (font-lock-doc-string-face ((t (:foreground "green4"))))
    (font-lock-function-name-face ((t (:foreground "darkorange"))))
    (font-lock-keyword-face ((t (:foreground "blue3"))))
    (font-lock-preprocessor-face ((t (:foreground "blue3"))))
    (font-lock-reference-face ((t (:foreground "red3"))))
    (font-lock-special-comment-face ((t (:foreground "blue4"))))
    (font-lock-special-keyword-face ((t (:foreground "red4"))))
    (font-lock-string-face ((t (:foreground "green4"))))
    (font-lock-type-face ((t (:foreground "steelblue"))))
    (font-lock-variable-name-face ((t (:foreground "black"))))
    (font-lock-warning-face ((t (:bold t :foreground "Red"))))
    (green ((t (:foreground "green"))))
    (gui-button-face ((t (:background "grey75" :foreground "black"))))
    (gui-element ((t (:background "azure1" :foreground "Black"))))
    (highlight ((t (:background "darkseagreen2" :foreground "blue"))))
    (holiday-face ((t (:background "pink" :foreground "black"))))
    (info-node ((t (:bold t))))
    (info-xref ((t (:bold t))))
    (isearch ((t (:background "yellow" :foreground "red"))))
    (italic ((t (:bold t))))
    (left-margin ((t (nil))))
    (list-mode-item-selected ((t (:background "gray68" :foreground "black"))))
    (message-cited-text-face ((t (:foreground "red"))))
    (message-header-cc-face ((t (:foreground "MidnightBlue"))))
    (message-header-name-face ((t (:foreground "cornflower blue"))))
    (message-header-newsgroups-face ((t (:bold t :foreground "blue4"))))
    (message-header-other-face ((t (:foreground "steel blue"))))
    (message-header-subject-face ((t (:bold t :foreground "navy blue"))))
    (message-header-to-face ((t (:bold t :foreground "MidnightBlue"))))
    (message-header-xheader-face ((t (:foreground "blue"))))
    (message-mml-face ((t (:foreground "ForestGreen"))))
    (message-separator-face ((t (:foreground "brown"))))
    (modeline ((t (:background "bisque2" :foreground "steelblue4"))))
    (modeline-buffer-id ((t (:background "bisque2" :foreground "blue4"))))
    (modeline-mousable ((t (:background "bisque2" :foreground "firebrick"))))
    (modeline-mousable-minor-mode ((t (:background "bisque2" :foreground "green4"))))
    (paren-blink-off ((t (:foreground "azure1"))))
    (paren-face ((t (:background "lightgoldenrod"))))
    (paren-match ((t (:background "bisque2"))))
    (paren-mismatch ((t (:background "DeepPink" :foreground "black"))))
    (paren-mismatch-face ((t (:background "DeepPink"))))
    (paren-no-match-face ((t (:background "yellow"))))
    (pointer ((t (:background "white" :foreground "blue"))))
    (primary-selection ((t (:background "gray65"))))
    (red ((t (:foreground "red"))))
    (right-margin ((t (nil))))
    (secondary-selection ((t (:background "paleturquoise"))))
    (shell-option-face ((t (:foreground "gray50"))))
    (shell-output-2-face ((t (:foreground "green4"))))
    (shell-output-3-face ((t (:foreground "green4"))))
    (shell-output-face ((t (:bold t))))
    (shell-prompt-face ((t (:foreground "blue3"))))
    (speedbar-button-face ((t (:foreground "green4"))))
    (speedbar-directory-face ((t (:foreground "blue4"))))
    (speedbar-file-face ((t (:foreground "cyan4"))))
    (speedbar-highlight-face ((t (:background "green"))))
    (speedbar-selected-face ((t (:underline t :foreground "red"))))
    (speedbar-tag-face ((t (:foreground "brown"))))
    (text-cursor ((t (:background "Red3" :foreground "bisque"))))
    (toolbar ((t (:background "Gray80"))))
    (underline ((t (:underline t))))
    (vertical-divider ((t (nil))))
    (vhdl-font-lock-attribute-face ((t (:foreground "Orchid"))))
    (vhdl-font-lock-directive-face ((t (:foreground "CadetBlue"))))
    (vhdl-font-lock-enumvalue-face ((t (:foreground "SaddleBrown"))))
    (vhdl-font-lock-function-face ((t (:foreground "DarkCyan"))))
    (vhdl-font-lock-generic-/constant-face ((t (:foreground "Gold3"))))
    (vhdl-font-lock-prompt-face ((t (:bold t :foreground "Red"))))
    (vhdl-font-lock-reserved-words-face ((t (:bold t :foreground "Orange"))))
    (vhdl-font-lock-translate-off-face ((t (:background "LightGray"))))
    (vhdl-font-lock-type-face ((t (:foreground "ForestGreen"))))
    (vhdl-font-lock-variable-face ((t (:foreground "Grey50"))))
    (vhdl-speedbar-architecture-face ((t (:foreground "Blue"))))
    (vhdl-speedbar-architecture-selected-face ((t (:underline t :foreground "Blue"))))
    (vhdl-speedbar-configuration-face ((t (:foreground "DarkGoldenrod"))))
    (vhdl-speedbar-configuration-selected-face ((t (:underline t :foreground "DarkGoldenrod"))))
    (vhdl-speedbar-entity-face ((t (:foreground "ForestGreen"))))
    (vhdl-speedbar-entity-selected-face ((t (:underline t :foreground "ForestGreen"))))
    (vhdl-speedbar-instantiation-face ((t (:foreground "Brown"))))
    (vhdl-speedbar-instantiation-selected-face ((t (:underline t :foreground "Brown"))))
    (vhdl-speedbar-package-face ((t (:foreground "Grey50"))))
    (vhdl-speedbar-package-selected-face ((t (:underline t :foreground "Grey50"))))
    (vhdl-speedbar-subprogram-face ((t (:foreground "Orchid4"))))
    (widget-button-face ((t (:bold t))))
    (widget-button-pressed-face ((t (:foreground "red"))))
    (widget-documentation-face ((t (:foreground "dark green"))))
    (widget-field-face ((t (:background "gray85"))))
    (widget-inactive-face ((t (:foreground "dim gray"))))
    (yellow ((t (:foreground "yellow"))))
    (zmacs-region ((t (:background "steelblue" :foreground "yellow")))))))
