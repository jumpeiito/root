;;; -*- coding: iso-2022-7bit -*-

;;;
;;; naga10-fontset.el
;;;


;;; 初期化ファイル ~/.emacs に次のように書いてください。
;;;
;;; (load "~/どこか/naga10-fontset")
;;;
;;; (setq default-frame-alist
;;;       (append (list
;;;               '(font . "naga10-fontset")
;;;                )
;;;               default-frame-alist))


;;; フォントの入手先など、詳しい情報については
;;;
;;;     http://kawacho.don.am/win/meadow/
;;;
;;; をご覧ください。


;;; ascii
(w32-auto-regist-bdf-font
 "naga10-ascii"
 "C:/TeX/fonts/naga10/5x10a.bdf" 0)
 (w32-change-font-logfont
  "naga10-ascii" 1 ; bold
  '(bdf-font "C:/TeX/fonts/naga10/5x10B.bdf")) ; 5x10B.bdf
; (w32-change-font-logfont
;  "naga10-ascii" 2 ; italic
;  '(bdf-font "C:/TeX/fonts/naga10/5x10ai.bdf"))
; (w32-change-font-logfont
;  "naga10-ascii" 3 ; bold-italic
;  '(bdf-font "C:/TeX/fonts/naga10/5x10abi.bdf"))

;;; latin-iso8859-1
(w32-auto-regist-bdf-font
 "naga10-latin-iso8859-1" 
 "C:/TeX/fonts/naga10/5x10a.bdf" 1)
 (w32-change-font-logfont
  "naga10-latin-iso8859-1" 1
  '(bdf-font "C:/TeX/fonts/naga10/5x10B.bdf")) ; 5x10B.bdf
; (w32-change-font-logfont
;  "naga10-latin-iso8859-1" 2
;  '(bdf-font "C:/TeX/fonts/naga10/5x10ai.bdf"))
; (w32-change-font-logfont
;  "naga10-latin-iso8859-1" 3
;  '(bdf-font "C:/TeX/fonts/naga10/5x10abi.bdf"))

;;; latin-jisx0201
(w32-auto-regist-bdf-font
 "naga10-latin-jisx0201"
 "C:/TeX/fonts/naga10/5x10rk.bdf" 0)
; (w32-change-font-logfont
;  "naga10-latin-jisx0201" 1
;  '(bdf-font "C:/TeX/fonts/naga10/5x10rk.bdf"))
; (w32-change-font-logfont
;  "naga10-latin-jisx0201" 2
;  '(bdf-font "C:/TeX/fonts/naga10/5x10rki.bdf"))
; (w32-change-font-logfont
;  "naga10-latin-jisx0201" 3
;  '(bdf-font "C:/TeX/fonts/naga10/5x10rkbi.bdf"))

;;; katakana-jisx0201
(w32-auto-regist-bdf-font 
 "naga10-katakana-jisx0201" 
 "C:/TeX/fonts/naga10/5x10rk.bdf" 1)
; (w32-change-font-logfont
;  "naga10-katakana-jisx0201" 1
;  '(bdf-font "C:/TeX/fonts/naga10/5x10rk.bdf"))
; (w32-change-font-logfont
;  "naga10-katakana-jisx0201" 2
;  '(bdf-font "C:/TeX/fonts/naga10/5x10rki.bdf"))
; (w32-change-font-logfont
;  "naga10-katakana-jisx0201" 3
;  '(bdf-font "C:/TeX/fonts/naga10/5x10rkbi.bdf"))

;;; japanese-jisx0208
(w32-auto-regist-bdf-font
 "naga10-japanese-jisx0208" 
 "C:/TeX/fonts/naga10/knj10.bdf" 0)
; (w32-change-font-logfont
;  "naga10-japanese-jisx0208" 1
;  '(bdf-font "C:/TeX/fonts/naga10/knj10b.bdf"))
; (w32-change-font-logfont
;  "naga10-japanese-jisx0208" 2
;  '(bdf-font "C:/TeX/fonts/naga10/knj10i.bdf"))
; (w32-change-font-logfont
;  "naga10-japanese-jisx0208" 3
;  '(bdf-font "C:/TeX/fonts/naga10/knj10bi.bdf"))



;;; naga10-fontset
(new-fontset "naga10-fontset" 
	     '((ascii             . "naga10-ascii")
	       (latin-iso8859-1   . "naga10-latin-iso8859-1")
	       (latin-jisx0201    . "naga10-latin-jisx0201")
	       (katakana-jisx0201 . "naga10-katakana-jisx0201")
	       (japanese-jisx0208 . "naga10-japanese-jisx0208")
	       ))


;; End of File
