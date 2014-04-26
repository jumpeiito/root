;;;
;;; meadow2-shinonome-fontset.el
;;;
;;; Author: KAWAHARA Masayoshi <kawacho@don.am>
;;;

;;; 使い方：
;;; 
;;; ~/.emacs に以下の内容を追加する。
;;; 
;;; ----------------------------------------------------------------------------
;;; 
;;; ;; 東雲フォントのファイルを置いたディレクトリ
;;; ;; $MEADOW/fonts/shinonome 以下に置いた場合は設定不要。
;;; ;; (setq bdf-font-directory-shinonome "C:/fonts/shinonome")
;;; 
;;; ;; 作成するフォントセット（不要なら nil にする）
;;; (setq bdf-use-shinonome12     t
;;;       bdf-use-shinonome12min  t
;;;       bdf-use-shinonome12maru t
;;;       bdf-use-shinonome14     t
;;;       bdf-use-shinonome14min  t
;;;       bdf-use-shinonome16     t
;;;       bdf-use-shinonome16min  t)
;;; 
;;; ;; このファイルを load する
;;; (load "どこか/meadow2-shinonome-fontset")
;;; 
;;; ;; デフォルトのフォントセットにする場合
;;; (setq default-frame-alist
;;;       (append (list 
;;;                '(font . "shinonome16min")
;;;                '(width . 100)
;;;                '(height . 63)
;;;                '(left . 30)
;;;                '(top . 20)
;;;                )
;;;               default-frame-alist))
;;; 
;;; ----------------------------------------------------------------------------
;;; 
;;; 作成されるフォントセットの一覧
;;; 
;;; - shinonome16     ... 16 ドット、ゴシック体
;;; - shinonome16min  ... 16 ドット、明朝体
;;; 
;;; - shinonome14     ... 14 ドット、ゴシック体
;;; - shinonome14min  ... 14 ドット、明朝体
;;; 
;;; - shinonome12     ... 12 ドット、ゴシック体
;;; - shinonome12min  ... 12 ドット、明朝体
;;; - shinonome12maru ... 12 ドット、丸文字
;;;

;; shinonome font file(*.bdf) directory
(defvar bdf-font-directory-shinonome
  (expand-file-name "c:/TeX/fonts/shinonome" data-directory))

;;
(add-to-list 'bdf-directory-list
	     bdf-font-directory-shinonome)

;;
(eval-after-load "ps-bdf"
  '(add-to-list 'bdf-directory-list 
		(expand-file-name "c:/tex/fonts/shinonome" data-directory)))
;;../../fonts/shinonome" data-directory)))


;;
(defvar bdf-use-shinonome12     nil)
(defvar bdf-use-shinonome12min  nil)
(defvar bdf-use-shinonome12maru nil)
(defvar bdf-use-shinonome14     nil)
(defvar bdf-use-shinonome14min  nil)
(defvar bdf-use-shinonome16     nil)
(defvar bdf-use-shinonome16min  nil)


;; 12dot gothic
(when bdf-use-shinonome12
  (defvar shinonome12-file-alist
    (append 
     '((ascii ("shnm6x12a.bdf"
	       "shnm6x12ab.bdf"
	       "shnm6x12ai.bdf"
	       "shnm6x12abi.bdf"))
       (latin-iso8859-1 ("shnm6x12a.bdf"
			 "shnm6x12ab.bdf"
			 "shnm6x12ai.bdf"
			 "shnm6x12abi.bdf") 1-byte-set-msb)
       (latin-jisx0201 ("shnm6x12r.bdf"
			"shnm6x12rb.bdf"
			"shnm6x12ri.bdf"
			"shnm6x12rbi.bdf"))
       (katakana-jisx0201 ("shnm6x12r.bdf"
			   "shnm6x12rb.bdf"
			   "shnm6x12ri.bdf"
			   "shnm6x12rbi.bdf") 1-byte-set-msb)
       (japanese-jisx0208 ("shnmk12.bdf"
			   "shnmk12b.bdf"
			   "shnmk12i.bdf"
			   "shnmk12bi.bdf")))))
  (require 'bdf)
  (bdf-configure-fontset "shinonome12" shinonome12-file-alist))


;; 12dot mincho
(when bdf-use-shinonome12min
  (defvar shinonome12min-file-alist
    (append 
     '((ascii ("shnm6x12a.bdf"
	       "shnm6x12ab.bdf"
	       "shnm6x12ai.bdf"
	       "shnm6x12abi.bdf"))
       (latin-iso8859-1 ("shnm6x12a.bdf"
			 "shnm6x12ab.bdf"
			 "shnm6x12ai.bdf"
			 "shnm6x12abi.bdf") 1-byte-set-msb)
       (latin-jisx0201 ("shnm6x12r.bdf"
			"shnm6x12rb.bdf"
			"shnm6x12ri.bdf"
			"shnm6x12rbi.bdf"))
       (katakana-jisx0201 ("shnm6x12r.bdf"
			   "shnm6x12rb.bdf"
			   "shnm6x12ri.bdf"
			   "shnm6x12rbi.bdf") 1-byte-set-msb)
       ;; mincho
       (japanese-jisx0208 ("shnmk12min.bdf"
			   "shnmk12minb.bdf"
			   "shnmk12mini.bdf"
			   "shnmk12minbi.bdf")))))
  (require 'bdf)
  (bdf-configure-fontset "shinonome12min" shinonome12min-file-alist))


;; 12dot marumoji
(when bdf-use-shinonome12maru
  (defvar shinonome12maru-file-alist
    (append 
     '((ascii ("shnm6x12a.bdf"
	       "shnm6x12ab.bdf"
	       "shnm6x12ai.bdf"
	       "shnm6x12abi.bdf"))
       (latin-iso8859-1 ("shnm6x12a.bdf"
			 "shnm6x12ab.bdf"
			 "shnm6x12ai.bdf"
			 "shnm6x12abi.bdf") 1-byte-set-msb)
       (latin-jisx0201 ("shnm6x12r.bdf"
			"shnm6x12rb.bdf"
			"shnm6x12ri.bdf"
			"shnm6x12rbi.bdf"))
       (katakana-jisx0201 ("shnm6x12r.bdf"
			   "shnm6x12rb.bdf"
			   "shnm6x12ri.bdf"
			   "shnm6x12rbi.bdf") 1-byte-set-msb)
       ;; marumoji
       (japanese-jisx0208 ("shnmk12maru.bdf"
			   "shnmk12marub.bdf"
			   "shnmk12marui.bdf"
			   "shnmk12marubi.bdf")))))
  (require 'bdf)
  (bdf-configure-fontset "shinonome12maru" shinonome12maru-file-alist))


;; 14dot gothic
(when bdf-use-shinonome14
  (defvar shinonome14-file-alist
    (append 
     '((ascii ("shnm7x14a.bdf"
	       "shnm7x14ab.bdf"
	       "shnm7x14ai.bdf"
	       "shnm7x14abi.bdf"))
       (latin-iso8859-1 ("shnm7x14a.bdf"
			 "shnm7x14ab.bdf"
			 "shnm7x14ai.bdf"
			 "shnm7x14abi.bdf") 1-byte-set-msb)
       (latin-jisx0201 ("shnm7x14r.bdf"
			"shnm7x14rb.bdf"
			"shnm7x14ri.bdf"
			"shnm7x14rbi.bdf"))
       (katakana-jisx0201 ("shnm7x14r.bdf"
			   "shnm7x14rb.bdf"
			   "shnm7x14ri.bdf"
			   "shnm7x14rbi.bdf") 1-byte-set-msb)
       (japanese-jisx0208 ("shnmk14.bdf"
			   "shnmk14b.bdf"
			   "shnmk14i.bdf"
			   "shnmk14bi.bdf")))))
  (require 'bdf)
  (bdf-configure-fontset "shinonome14" shinonome14-file-alist))


;; 14dot mincho
(when bdf-use-shinonome14min
  (defvar shinonome14min-file-alist
    (append 
     '((ascii ("shnm7x14a.bdf"
	       "shnm7x14ab.bdf"
	       "shnm7x14ai.bdf"
	       "shnm7x14abi.bdf"))
       (latin-iso8859-1 ("shnm7x14a.bdf"
			 "shnm7x14ab.bdf"
			 "shnm7x14ai.bdf"
			 "shnm7x14abi.bdf") 1-byte-set-msb)
       (latin-jisx0201 ("shnm7x14r.bdf"
			"shnm7x14rb.bdf"
			"shnm7x14ri.bdf"
			"shnm7x14rbi.bdf"))
       (katakana-jisx0201 ("shnm7x14r.bdf"
			   "shnm7x14rb.bdf"
			   "shnm7x14ri.bdf"
			   "shnm7x14rbi.bdf") 1-byte-set-msb)
       ;; mincho
       (japanese-jisx0208 ("shnmk14min.bdf"
			   "shnmk14minb.bdf"
			   "shnmk14mini.bdf"
			   "shnmk14minbi.bdf")))))
  (require 'bdf)
  (bdf-configure-fontset "shinonome14min" shinonome14min-file-alist))


;; 16dot gothic
(when bdf-use-shinonome16
  (defvar shinonome16-file-alist
    (append 
     '((ascii ("shnm8x16a.bdf"
	       "shnm8x16ab.bdf"
	       "shnm8x16ai.bdf"
	       "shnm8x16abi.bdf"))
       (latin-iso8859-1 ("shnm8x16a.bdf"
			 "shnm8x16ab.bdf"
			 "shnm8x16ai.bdf"
			 "shnm8x16abi.bdf") 1-byte-set-msb)
       (latin-jisx0201 ("shnm8x16r.bdf"
			"shnm8x16rb.bdf"
			"shnm8x16ri.bdf"
			"shnm8x16rbi.bdf"))
       (katakana-jisx0201 ("shnm8x16r.bdf"
			   "shnm8x16rb.bdf"
			   "shnm8x16ri.bdf"
			   "shnm8x16rbi.bdf") 1-byte-set-msb)
       (japanese-jisx0208 ("shnmk16.bdf"
			   "shnmk16b.bdf"
			   "shnmk16i.bdf"
			   "shnmk16bi.bdf")))))
  (require 'bdf)
  (bdf-configure-fontset "shinonome16" shinonome16-file-alist))


;; 16dot mincho
(when bdf-use-shinonome16min
  (defvar shinonome16min-file-alist
    (append 
     '((ascii ("shnm8x16a.bdf"
	       "shnm8x16ab.bdf"
	       "shnm8x16ai.bdf"
	       "shnm8x16abi.bdf"))
       (latin-iso8859-1 ("shnm8x16a.bdf"
			 "shnm8x16ab.bdf"
			 "shnm8x16ai.bdf"
			 "shnm8x16abi.bdf") 1-byte-set-msb)
       (latin-jisx0201 ("shnm8x16r.bdf"
			"shnm8x16rb.bdf"
			"shnm8x16ri.bdf"
			"shnm8x16rbi.bdf"))
       (katakana-jisx0201 ("shnm8x16r.bdf"
			   "shnm8x16rb.bdf"
			   "shnm8x16ri.bdf"
			   "shnm8x16rbi.bdf") 1-byte-set-msb)
       ;; mincho
       (japanese-jisx0208 ("shnmk16min.bdf"
			   "shnmk16minb.bdf"
			   "shnmk16mini.bdf"
			   "shnmk16minbi.bdf")))))
  (require 'bdf)
  (bdf-configure-fontset "shinonome16min" shinonome16min-file-alist))


;;; meadow2-shinonome-fontset.el ends here.
