
  (autoload 'color-theme-install "color-theme" "color-theme" t)


(defun color-theme-robin-hood ()
  "`color-theme-gnome2' with navajo white on green.
This theme tries to avoid underlined and italic faces, because
the fonts either look ugly, or do not exist.  The author himself
uses neep, for example."
  (interactive)
  (color-theme-gnome2)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-robin-hood
       ((foreground-color . "navajo white")
	(background-color . "#304020"))
       ((CUA-mode-read-only-cursor-color . "white")
	(help-highlight-face . info-xref)
	(list-matching-lines-buffer-name-face . bold))
       (default ((t (nil))))
       (button ((t (:bold t))))
       (calendar-today-face ((t (:foreground "lemon chiffon"))))
       (custom-button-face ((t (:bold t :foreground "DodgerBlue1"))))
       (diary-face ((t (:bold t :foreground "yellow"))))
       (fringe ((t (:background "#003700"))))
       (header-line ((t (:background "#030" :foreground "#AA7"))))
       (holiday-face ((t (:bold t :foreground "peru"))))
       (ido-subdir-face ((t (:foreground "MediumSlateBlue"))))
       (isearch ((t (:foreground "pink" :background "red"))))
       (isearch-lazy-highlight-face ((t (:foreground "red"))))
       (menu ((t (:background "#304020" :foreground "navajo white"))))
       (minibuffer-prompt ((t (:foreground "pale green"))))
       (modeline ((t (:background "dark olive green" :foreground "wheat" :box (:line-width 1 :style released-button)))))
       (mode-line-inactive ((t (:background "dark olive green" :foreground "khaki" :box (:line-width 1 :style released-button)))))
       (semantic-dirty-token-face ((t (:background "grey22"))))
       (tool-bar ((t (:background "#304020" :foreground "wheat" :box (:line-width 1 :style released-button)))))
       (tooltip ((t (:background "lemon chiffon" :foreground "black"))))))))
