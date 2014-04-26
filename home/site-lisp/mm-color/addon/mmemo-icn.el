;; 色一覧バッファから色を選ぶ
;; もともといたバッファに色の名前の文字列を挿入する
(defvar color-selection-all-list-mode-map nil
  "Keymap for color selection list major mode.")

(if color-selection-all-list-mode-map
    nil
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-m" 'color-selection-choose-colorname)
    (setq color-selection-all-list-mode-map map)))

(defun color-selection-list-choose-color ()
  "Choose the color that point is in."
  (interactive)
  (let ((color-name ""))
    (setq color-name (cdr (get-text-property (point) 'face)))
    (setq color-name (concat color-selection-list-prefix-string
                             (substring color-name 1 (length color-name))))
    (kill-buffer (current-buffer))
    (set-buffer color-selection-list-original-buffer)
    (insert color-name)))

(defun color-selection-all-list-mode ()
  (interactive)
  (kill-all-local-variables)
  (text-mode)
  (setq major-mode 'color-selection-all-list-mode)
  (setq mode-name "color selection list mode")
  (use-local-map color-selection-all-list-mode-map)
  (run-hooks 'color-selection-all-list-mode-hook))

(defun insert-color-name ()
  (interactive)
  (let ((r 0)
        (g 0)
        (b 0)
        (delta 32)
        (color-list ()))
    (setq color-selection-list-original-buffer (current-buffer))
    (setq color-list (defined-colors))
    ;; Delete duplicate colors.
    (let ((l color-list))
      (while (cdr l)
        (if (facemenu-color-equal (car l) (car (cdr l)))
            (setcdr l (cdr (cdr l)))
          (setq l (cdr l)))))
    (color-selection-list-colors-display color-list)
    (color-selection-all-list-mode)))

(defun color-selection-choose-colorname ()
  "Choose the color that point is in."
  (interactive)
  (let ((color-name ""))
    (setq color-name (cdr (get-text-property (point) 'face)))
    (setq color-name (concat (substring color-name 0 (length color-name))))
    (kill-buffer (current-buffer))
    (set-buffer color-selection-list-original-buffer)
    ;; (delete-region (line-beginning-position) (line-end-position))
    (insert color-name)))
