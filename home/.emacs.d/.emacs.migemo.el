;; ;; ��������
;; ;; (setq migemo-command "F:\\home\\site-lisp\\cmigemo\\cmigemo.exe")
;; ;; (setq migemo-command "f:/home/site-lisp/cmigemo/cmigemo.exe")
;; (setq usb-drive-letter (substring data-directory 0 3))
;; ;; (setq migemo-command (concat usb-drive-letter
;; ;; 			     "home/site-lisp/cmigemo/cmigemo.exe"))
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
;; ;; migemo-dict �Υѥ������
;; ;;(setq migemo-dictionary "~/site-lisp/dict/cp932/migemo-dict")
;; ;(setq migemo-dictionary "F:\\home\\site-lisp\\dict\\cp932\\migemo-dict")
;; (setq migemo-dictionary (concat usb-drive-letter
;; 				;"home/site-lisp/dict/cp932/migemo-dict"
;; 				"cmigemo/dict/migemo-dict"))
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)

;; ;; ����å��嵡ǽ�����Ѥ���
;; (setq migemo-use-pattern-alist t)
;; (setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-pattern-alist-length 1024)
;; ;; �����ʸ�������ɤ���ꡥ
;; ;; �Х��ʥ�����Ѥ���ʤ顤���Τޤޤǹ����ޤ���
;; ;(setq migemo-coding-system 'euc-jp-unix)
;; ;(setq migemo-coding-system 'utf-8-unix)

;; (load-library "migemo")
;; ;; ��ư���˽������Ԥ�
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
;; ����å����ͭ����
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1000)
;; �����ʸ�������ɤ����
(setq migemo-coding-system 'utf-8-unix)
;; �����
(migemo-init)