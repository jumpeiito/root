;; ;; 基本設定
;; ;; (setq migemo-command "F:\\home\\site-lisp\\cmigemo\\cmigemo.exe")
;; ;; (setq migemo-command "f:/home/site-lisp/cmigemo/cmigemo.exe")
;; (setq usb-drive-letter (substring data-directory 0 3))
;; ;; (setq migemo-command (concat usb-drive-letter
;; ;; 			     "home/site-lisp/cmigemo/cmigemo.exe"))
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
;; ;; migemo-dict のパスを指定
;; ;;(setq migemo-dictionary "~/site-lisp/dict/cp932/migemo-dict")
;; ;(setq migemo-dictionary "F:\\home\\site-lisp\\dict\\cp932\\migemo-dict")
;; (setq migemo-dictionary (concat usb-drive-letter
;; 				;"home/site-lisp/dict/cp932/migemo-dict"
;; 				"cmigemo/dict/migemo-dict"))
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)

;; ;; キャッシュ機能を利用する
;; (setq migemo-use-pattern-alist t)
;; (setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-pattern-alist-length 1024)
;; ;; 辞書の文字コードを指定．
;; ;; バイナリを利用するなら，このままで構いません
;; ;(setq migemo-coding-system 'euc-jp-unix)
;; ;(setq migemo-coding-system 'utf-8-unix)

;; (load-library "migemo")
;; ;; 起動時に初期化も行う
;; (migemo-init)

(setq usb-drive-letter (substring data-directory 0 3))
(add-to-list 'exec-path
	     ;; (concat usb-drive-letter
	     ;; 	     "cmigemo")
	     "F:/cmigemo")

(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
(setq migemo-dictionary
      "f:/cmigemo/dict/utf-8/migemo-dict"
      ;; (concat usb-drive-letter
      ;; 	      "f:/cmigemo/dict/utf-8/migemo-dict")
      )

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
;; キャッシュの有効化
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1000)
;; 辞書の文字コードを指定
(setq migemo-coding-system 'utf-8-unix)
;; 初期化
(migemo-init)
