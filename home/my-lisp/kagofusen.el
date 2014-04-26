(defmacro klet1 (sym symval &rest clause)
  `(let ((,sym ,symval))
     ,@clause))

;; (defmacro if-klet1 (sym val ifbody &optional elsebody)
;;   `(if ,val
;;        (klet1 ,sym ,val ,ifbody)
;;      ,elsebody))

(defun list-multiple (l1 l2)
  (klet1 l (if (and (symbolp (car l2)) (fboundp (car l2))) (eval l2) l2)
	(letrec ((returner (lambda (xx1 xx2 r)
			     (if (or (null xx1) (null xx2))
				 (reverse r)
			       (funcall returner (cdr xx1) (cdr xx2) (cons (list (car xx1) (car xx2)) r))))))
	  (funcall returner l1 l '()))))

(defmacro k-multiple-value-bind (symlist vallist &rest clause)
  `(let* ,(list-multiple symlist vallist)
     ,@clause))

;; (string-case str ("foo" f1) ("buz" f2) (t f3))
;; (cond ((string= str "foo") f1))
(defmacro kgf-string-case (str &rest clause)
  `(cond ,@(mapcar (lambda (l) (if (equal (first l) t) `(t ,(second l))
			     `((string= ,str ,(first l)) ,(second l)))) clause)))

(defmacro with-buffer (bf &rest body)
  `(progn
     (set-buffer ,bf)
     ,@body
     (save-buffer ,bf)
     (kill-buffer ,bf)))

(defvar usb-drive-letter (substring data-directory 0 3))
(defvar kgf-file (concat usb-drive-letter ".kgf"))

(defun kgf-save (type start end)
  (let ((buf (find-file-noselect kgf-file))
	(str (buffer-substring-no-properties start end)))
    (with-buffer buf
      (goto-char (point-max))
      (insert "* "
	    (format-time-string "%Y/%m/%d %H:%M:%S ") 
	    type "\n"
	    str "\n"))))

(defun kagofusen ()
  (interactive)
  (let* ((mm (- (string-to-number (format-time-string "%m")) 
		2))
	 (l  ""))
    (while (not (= 3 (split-string l " ")))
      (setq l (read-from-minibuffer "年 月 日 :"))
      )))

(defun kgf-base ()
  (interactive) 
  (let* ((cp (point))
	 (m (read-char "(0)証記号番号エラー (1)生保・社保・他国保 (2)取得前受診 (3)喪失後受診 (4)給付割合相違"))
	 (type ""))
    (case m
      (48 (setq type (kgf-base-kigou)))
      (49 (setq type (kgf-base-hoken)))
      (50 (setq type (kgf-base-before)))
      (51 (setq type (kgf-base-after)))
      (52 (setq type (kgf-base-ratio)))
      (t (message "error")))
    (kill-ring-save cp (point))
    (kgf-save type cp (point))))

(defmacro >> (&rest args)
  `(insert (concat ,@args)))

(defun kgf-base-before ()
  (>> "資格取得日…"
      (kgf-time-from-minibuffer "資格取得日")
      "\n証発行日…"
      (kgf-time-from-minibuffer "証発行日" (car minibuffer-history))
      "\n")
  "資格取得前受診")


(defun kgf-base-after ()
  (>> "資格喪失日…"
      (kgf-time-from-minibuffer "資格喪失日")
      "\n"
      "証回収日…"
      (kgf-time-from-minibuffer "証回収日" (car minibuffer-history))
      "\n")
  "資格喪失後受診")

(defun kgf-base-hoken ()
  (let ((m (read-char "(0)生活保護 (1)社会保険・他国保組合 (2)市町村国保")))
    (insert "資格喪失日…" (kgf-time-from-minibuffer "資格喪失日") "\n"
	    (let ((lostday (car minibuffer-history)))
	      (concat "証回収日…"
		      (kgf-time-from-minibuffer "証回収日" lostday) "\n"
		      (case m
			(48 (concat "生活保護認定日…" 
				    (kgf-time-from-minibuffer "生活保護認定日" lostday) "\n"
				    "生活保護適用\n"
				    (kgf-hospital)))
			(49 (concat "資格取得日…"
				    (kgf-time-from-minibuffer "資格取得日" lostday) "\n"
				    "保険者番号…"
				    (case (read-char "(0)協会けんぽ(京都) (1)協会けんぽ(大阪) (2)協会けんぽ(滋賀) (3)協会けんぽ(東京) (4)その他")
				      (48 "01260017")
				      (49 "01270016")
				      (50 "01250018")
				      (51 "01130012")
				      (52 (read-from-minibuffer "保険者番号: "))) 
				    "\n"
				    "記号…" (read-from-minibuffer "記号: ") "  "
				    "番号…" (read-from-minibuffer "番号: ") ""
				    "("
				    (case (read-char "(0)本人 (1)家族")
				      (48 "本人")
				      (49 "家族"))
				    ")\n"
				    (kgf-hospital)))
			(50 (concat "市町村国保へ移行\n"
				    (kgf-hospital))))))
	    "")
    (case m
      (48 "生活保護に移行")
      (49 "社会保険・国保組合に移行")
      (50 "市町村国保に移行"))))

(defun string-join (list joiner)
  (labels ((in (subl str)
	     (if (null subl)
		 str
		 (in (cdr subl)
		     (concat str
			     (if (string= str "") "" joiner)
			     (car subl))))))
    (in list "")))

;; (string-join '("hoge" "foo") ",")
(defun kgf-base-ratio ()
  (interactive)
  (let ((l '("7割" "8割(9割)")))
    (insert "前期高齢者受給者証の負担割合をご確認下さい。\n"
	    (string-join
	     (funcall (if (eq 48 (read-char "(0) 7割→9割 (1) 9割→7割"))
			  #'identity #'reverse)
		      l)
	     "→"))
    "給付割合相違"))

(defmacro with-skk-on (&rest body)
  `(progn
     (add-hook 'minibuffer-setup-hook 'skk-auto-fill-mode-minus)
     (let ((this ,@body))
       (remove-hook 'minibuffer-setup-hook 'skk-auto-fill-mode-minus)
       this)))

(defun kgf-hospital ()
  (concat "医療機関  "
	  (with-skk-on
	      (read-from-minibuffer "医療機関対応者: "))
	  "様了解"
	  " ("
	  (read-from-minibuffer "確認日: "
				(format-time-string "%m月%d日"))
	  ")"))


(defun kgf-number-special ()
  (let* ((ss (split-string (kgf-number) "-"))
	 (sb (nth 0 ss))
	 (sa (nth 1 ss)))
    (concat "記号…" sb "  "
	    "番号…" sa "  ")))

(defun kgf-base-kigou ()
  (let ((m (read-char "(0)記号番号 (1)氏名 (2)生年月日 (3)公費番号")))
    (case m
      (48 ;; 記号番号エラー
       (insert "保険証の記号番号のご確認をお願いします。"
	       (kgf-number)
	       "→"
	       (kgf-number))
       "記号番号エラー (記号番号)")
      (49 ;;氏名エラー
       (insert "氏名のご確認をお願いします。"
	       (read-from-minibuffer "訂正前氏名: ")
	       "→"
	       (read-from-minibuffer "訂正後氏名: "))
       "記号番号エラー (氏名)")
      (50 ;; 誕生日エラー
       (insert "生年月日のご確認をお願いします。"
	       (kgf-time-from-minibuffer)
	       "→"
	       (kgf-time-from-minibuffer))
       "記号番号エラー (生年月日)")
      ;; (51 (kgf-base-kouhi))
      (t (message "error")))))

;; (defun kgf-time-from-minibuffer (&optional prompt default)
;;   (interactive)
;;   (let ((mm '()))
;;     (while (kgf-time-test mm)
;;       (setq mm (split-string 
;; 		(read-from-minibuffer (concat "元号 年 月 日"
;; 					      (if prompt (concat "(" prompt ")") "")
;; 					      ": ")
;; 				      default)))
;;       (when (kgf-time-test mm)
;; 	(progn
;; 	  (message "入力された日時が正しくありません。")
;; 	  (sleep-for 2))))
;;     (let ((g (string-to-int (nth 0 mm)))
;; 	  (y (nth 1 mm))
;; 	  (m (nth 2 mm))
;; 	  (d (nth 3 mm)))
;;       (let ((gg (case g (2 "大正") (3 "昭和") (4 "平成")))
;; 	    (yy (concat y "年"))
;; 	    (mo (concat m "月"))
;; 	    (dd (concat d "日")))
;; 	(concat gg yy mo dd)))))

;; (defun kgf-time-from-minibuffer (&optional prompt default)
;;   (interactive)
;;   (klet1 mm '()
;; 	(while (kgf-time-check mm)
;; 	  (setq mm (split-string (read-from-minibuffer
;; 				  (concat "元号 年 月 日" (if prompt (concat "(" prompt ")") "") ": ")
;; 				  default)))
;; 	  (when (kgf-time-check mm)
;; 	    (progn
;; 	      (message "入力された日時が正しくありません。")
;; 	      (sleep-for 2))))
;; 	(k-multiple-value-bind (g y m d) (mapcar (lambda (xl) (funcall 'nth xl mm)) '(0 1 2 3))
;; 	  (concat (kgf-string-case g
;; 				   ("1" "明治")
;; 				   ("2" "大正")
;; 				   ("3" "昭和")
;; 				   ("4" "平成"))
;; 		  y "年"
;; 		  m "月"
;; 		  d "日"))))

(defun string-split-from-list (string list)
;;   "(string-split-from-list \"black brown\" '(1 2 3))
;; -> '(\"b\" \"la\" \"ck \")"
  (labels ((in (subl substr r)
	     (if (null subl)
		 (reverse r)
		 (in (cdr subl) (subseq substr (car subl))
		     (cons (subseq substr 0 (car subl)) r)))))
    (in list string nil)))

;; (string-split-from-list "black blown" '(1 2 3))
;; (string-split-from-list "3450623" '(1 2 2 2))

(defun timestring-from-minibuffer-parse (string)
  (if (not (eq 7 (length string)))
      nil
      (string-split-from-list string '(1 2 2 2))))

(defun kgf-time-from-minibuffer (&optional prompt default)
  (interactive)
  (klet1 mm '()
	 (while (kgf-time-check mm)
	   (setq mm (timestring-from-minibuffer-parse
		     (read-from-minibuffer
		      (concat "元号 年 月 日" (if prompt (concat "(" prompt ")") "") ": ")
		      default)))
	   (when (kgf-time-check mm)
	     (message "入力された日時が正しくありません。")
	     (sleep-for 1)))
	 (k-multiple-value-bind (g y m d) (mapcar (lambda (xl) (funcall 'nth xl mm)) '(0 1 2 3))
	  (concat (kgf-string-case g
				   ("1" "明治")
				   ("2" "大正")
				   ("3" "昭和")
				   ("4" "平成"))
		  y "年"
		  m "月"
		  d "日"))))

(defun kgf-number ()
  (interactive)
  (klet1 sm (read-from-minibuffer "記号番号(8ケタ)：")
	(cond
	 ((string= sm "p")		; "p"を入れると直前に入力した記号番号が入る
	  (setq sm (cadr minibuffer-history)))
	 ((string= sm "q")		; "q"を入れると直前に入力した記号番号を建12に直したものが入る
	  (klet1 m (cadr minibuffer-history)
		(setq sm (concat "3" (substring m 1))))))
	(let* ((sb (string-to-int (substring sm 1 3)))
	       (shibu (case sb
			(10 "北") (11 "上") (12 "中") (13 "下") (14 "南")
			(15 "左") (16 "東") (17 "山") (18 "右") (19 "西")
			(20 "伏") (21 "醍") (50 "乙") (51 "宇") (53 "亀")
			(54 "船") (56 "綾") (57 "福") (58 "舞") (59 "宮")
			(60 "奥") (61 "相") (62 "洛") (63 "綴") (85 "法")
			(90 "表") (95 "電") (else "□")))
	       (yy (concat "建1" (substring sm 0 1))))
	  (concat yy shibu (int-to-string sb) "-" (substring sm 3)))))

(defun kgf-time-base (arg)
  (case arg
    ('gengou "平成")
    ('year   (+ 12 (string-to-int (format-time-string "%y"))))
    ('month  (- (string-to-int (format-time-string "%m")) 2))
    ('day    1)))

(defun kgf-from-to (x min max)
  (and (>= x min) (<= x max)))

(defun kgf-time-check (arg)
  (klet1 a '((1 . 44) (2 . 15) (3 . 64) (4 . 26))
	(if (and (listp arg) (= 4 (length arg)))
	    (k-multiple-value-bind (g y m d) (mapcar 'string-to-int arg)
	      (not (and (>= g 1) (<= g 4)
			(kgf-month-day-check m d)
			(kgf-from-to y 1 (cdr (assoc g a))))))
	  t)))

(defun kgf-month-day-check (month day)
  (klet1 a '((1 . 31) (2 . 28) (3 . 31)  (4 . 30)  (5 . 31) (6 . 30)
	    (7 . 31) (8 . 31) (9 . 30) (10 . 31) (11 . 30) (12 . 31))
	(if (and (integerp month) (integerp day) (<= 1 month) (>= 12 month)
		 (kgf-from-to day 1 (cdr (assoc month a))))
	    t
	  nil)))

(global-set-key "\C-c\C-p" 'kgf-base)

(defun string-to-kgbg ()
  (interactive "r")
  (let* ((b (region-beginning))
	 (e (region-end))
	 (s (buffer-substring-no-properties b e)))
    ))
