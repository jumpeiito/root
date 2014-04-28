(setq load-path (append '("~/site-lisp/yatex/") load-path))

(setq auto-mode-alist
      (cons (cons "\\.tex\\|gen$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

;(setq dvi2-command "dviout")
;;; タイプセッタ
(setq tex-command "f:/tex/bin/platex-utf8.exe")
;;; プレヴューア
(setq dvi2-command "xdvi-ja.real")
; dviからpdfを作成する%sはファイル名
(setq dviprint-command-format "f:/tex/bin/dvipdfmxexe -p a4 -d 5 %s")
;(setq dviprint-command-format "dfx %s")

;;; 漢字コード
;;;   1=Shift JIS >== Windows なら
;;;   2=JIS
;;;   3=EUC
;;;   4=UTF-8
(setq YaTeX-kanji-code 4)

;;; LaTeX2e を使う
(setq YaTeX-use-LaTeX2e t)

;;; 色付け
(setq YaTeX-use-hilit19 nil)
(setq YaTeX-use-font-lock t)

(cond
 ((featurep 'font-lock)
  (defface font-latex-math-face
    '((((class grayscale) (background light)) 
       (:foreground "DimGray" :underline t))
      (((class grayscale) (background dark)) 
       (:foreground "LightGray" :underline t))
      (((class color) (background light)) (:foreground "SaddleBrown"))
      (((class color) (background dark))  (:foreground "burlywood"))
      (t (:underline t)))
    "Font Lock mode face used to highlight math in LaTeX."
    :group 'font-latex-highlighting-faces)
  
  (defface font-latex-label-face
    '((((class static-color)) (:foreground "yellow" :underline t))
      (((type tty)) (:foreground "yellow" :underline t))
      (((class color) (background dark)) (:foreground "pink"))
      (((class color) (background light)) (:foreground "gold3"))
      (t (:bold t :underline t)))
    "Font Lock mode face used to highlight labels."
    :group 'font-lock-faces)))

(setq YaTeX-font-lock-formula-face 'font-latex-math-face
      YaTeX-font-lock-label-face 'font-latex-label-face)

;; skk 対策
(add-hook 'skk-mode-hook
          (lambda ()
            (if (eq major-mode 'yatex-mode)
                (progn
                  (define-key skk-j-mode-map "\\" 'self-insert-command)
                  (define-key skk-j-mode-map "$" 'YaTeX-insert-dollar)
                  ))
            ))

(load "latex-input-method")

(add-hook 'yatex-mode-hook
	  (lambda ()
	    (YaTeX-font-lock-recenter)
	    (define-key YaTeX-mode-map "\C-c\C-p" 'latex-input-method)
	    (define-key YaTeX-mode-map "\C-c\C-k" 'latex-make-kaitou)
	    ;; (define-key YaTeX-mode-map "\C-c\C-c" (lambda () (interactive) (save-window-excursion (call-interactively 'compile))))
	    (define-key YaTeX-mode-map "\C-c\C-c" 'compile)
	    (define-key YaTeX-mode-map "\C-l" 'YaTeX-font-lock-recenter)
	    (auto-fill-mode -1)))
