(eval-when (:load-toplevel :compile-toplevel :execute)
  #+sbcl  (require :util)
  #+sbcl  (ql:quickload :closure-html)
  (ql:quickload :drakma)
  #+clisp (ql:quickload :util)
  #+clisp (ql:quickload :closure-html))

(defpackage #:news-develop
  (:nicknames #:newsd)
  (:use :cl :util :iterate :cl-ppcre)
  #+sbcl (:import-from #:sb-ext #:run-program)
  (:import-from #:xpath
		#:with-namespaces
		#:evaluate
		#:map-node-set->list
		#:string-value)
  (:import-from #:local-time
		#:timestamp-year
		#:timestamp-month
		#:timestamp-day
		#:today)
  (:import-from #:util #:make-date-literally))

(in-package #:newsd)

(defparameter sub-newline "%%newline%%")
(defparameter folding-length	34)
(defparameter topdir		"f:/Org/")
(defparameter terminal-char     '("。" "、" "ー" "」" ")" "）" "”"))
(defparameter starting-char	'("「" "(" "『" "（" "“"))

(defvar alist
  '(("朝日" . "4848832")
    ("毎日" . "4848854")
    ("読売" . "4848855")
    ("日経" . "4848856")
    ("東京" . "4848858")
    ("産経" . "4848857")))

(defun string-fold (string)
  "指定された文字数(news-base::folding-length)で文字列を折り返し、行頭に空白を付けたす。"
  (labels ((inner (subst r)
	     (if (>= folding-length (length subst))
		 (format nil "~{   ~A~^~%~}"
			 ;; 最後に空行が出力されないようにする処理
			 (if (string= subst "")
			     (reverse r)
			     (reverse (cons subst r))))
		 (let* ((flen  folding-length)
			(nextS (subseq subst flen (1+ flen)))
			(previous (subseq subst (1- flen) flen))
			(_flen
			 (cond
			   ;; 折り返し文字の次の字が「。」や「、」のと
			   ;; きに、1文字繰り上げて、「。」「、」が行の
			   ;; 最後に来るようにする。(禁則処理)
			   ((member nextS terminal-char :test #'equal)
			    (1+ flen))
			   ;; 折り返し文字が「「」などにならないように
			   ;; する。
			   ((member previous starting-char :test #'equal)
			    (1- flen))
			   (t flen))))
		   (inner (subseq subst _flen)
			  (cons (subseq subst 0 _flen) r))))))
    (inner (ppcre:regex-replace "^　" string "")
	   nil)))

(defstruct ARTICLE title body date day)

(defclass PAPER ()
  ((url		 :accessor url->     :initarg :url)
   (name	 :accessor name->    :initarg :name)
   (stp		 :accessor stp->     :initarg :stp)
   (body-parser  :accessor bparser-> :initarg :body-parser :initform #'identity)
   (title-parser :accessor tparser-> :initarg :title-parser :initform #'identity)
   (coding	 :accessor coding->  :initarg :coding :initform :SJIS)
   (bodies	 :accessor bodies->  :initarg :bodies :initform nil)
   (titles	 :accessor titles->  :initarg :titles :initform nil)
   (list	 :accessor list->    :initarg :list :initform nil)))

(defclass AKAHATA (PAPER)
  ((date	:accessor date-> :initarg :date :initform (today))))

(defun prelude-action (string)
  "<br/>が消えてしまうので、他のもので段落区切りを付けておく。"
  (ppcre:regex-replace-all "<br */>" string sub-newline))

(defun get-html (url coding)
  (prelude-action
   (sb-ext:octets-to-string
    (drakma:http-request url :external-format-in :dummy)
    :external-format coding)))

(defgeneric get-stp (obj))
(defmethod get-stp (url)
  (chtml:parse (get-html url :SJIS)
	       (stp:make-builder)))

(defmethod get-stp ((p PAPER))
  (chtml:parse (get-html (url-> p) (coding-> p))
	       (stp:make-builder)))

(defun last-space-length-count (string)
  (iter (for c :in-string (reverse string))
	(for n :upfrom 0)
	(if (or (char-equal #\IDEOGRAPHIC_FULL_STOP c)
		(char-equal #\RIGHT_CORNER_BRACKET c))
	    (leave n)
	    (next-iteration))))

(defun kill-last-space (string)
  (aif (last-space-length-count string)
       (subseq string 0 (- (length string) it))
       string))

(defun string-to-body (node)
  (remove-if #'string-null
	     (funcall (compose
		       (lambda (str) (ppcre:split sub-newline str))
		       #'kill-last-space
		       #'xpath:string-value)
		      node)))

(defun make-parser (stp &key xpath getfunc (remove-if-not #'identity))
  (with-namespaces (("h" "http://www.w3.org/1999/xhtml"))
    (remove-if-not
     remove-if-not
     (map-node-set->list
      getfunc
      (evaluate xpath stp)))))

(defun ordinary-body-parser (stp)
  (make-parser stp
	       :xpath   "//h:div[@class='text']"
	       :getfunc #'string-to-body))

(defun ordinary-title-parser (stp)
  (make-parser stp
	       :xpath "//h:div[@class='blogbody']/h:h3[@class='title']/h:a"
	       :getfunc #'string-value))

(defun akahata-title-parser (stp)
  (make-parser stp
	       :xpath "//h:li[@class='newslist']"
	       :getfunc #'string-value))

(defun akahata-date-parser (stp)
  (make-parser stp
	       :xpath "//h:li[@class='current']/h:a"
	       :getfunc #'string-value))

(defun today-from-stp (stp)
  (util::strdt (format nil "~A年~A"
		       (timestamp-year (today))
		       (car (akahata-date-parser stp)))))

(defun node-to-href (node)
  (stp:attribute-value
   (stp:find-child-if (lambda (stp) (equal "a" (stp:local-name stp)))
		  node)
   "href"))

(defun make-akahata-url (date &key (page "index.html"))
  (format nil "http://www.jcp.or.jp/akahata/aik14/~A-~2,'0d-~2,'0d/~A"
	  (timestamp-year date)
	  (timestamp-month date)
	  (timestamp-day date)
	  page))

(defun node-to-href-url (date node)
  (make-akahata-url date :page (node-to-href node)))

(defun akahata-article-reader (date)
  (lambda (node)
    (make-parser (get-stp (node-to-href-url date node))
		 :xpath "//h:div[@id='content']//h:p"
		 :getfunc #'string-value
		 :remove-if-not
		 (lambda (str)
		   (and (not (string= "" str))
			(string= "　" (subseq str 0 1)))))))

(defun akahata-body-parser (stp)
  (let ((date (today-from-stp stp)))
    (make-parser stp
		 :xpath "//h:li[@class='newslist']"
		 :getfunc (akahata-article-reader date))))

(defun title-parse-date (title)
  (ppcre:register-groups-bind (date)
      ("\\[.+新聞\\].+\\((\\d{4}年\\d{2}月\\d{2}日)\\)"
       title)
    (strdt date)))

(defgeneric make-articles (org))
(defmethod make-articles ((p PAPER))
  (iter (for title :in (titles-> p))
	(for body :in (bodies-> p))
	(for date = (title-parse-date title))
	(cond
	  ((not date)
	   (warn "This title(~A) may be inappropriate" title))
	  (t
	   (collect (make-article :title title
				  :body body
				  :date date
				  :day (local-time:timestamp-day date)))))))

(defmethod make-articles ((a AKAHATA))
  (iter (with date = (date-> a))
	(for title :in (titles-> a))
	(for body :in (bodies-> a))
	(cond
	  ((not date)
	   (warn "This title(~A) may be inappropriate" title))
	  (t
	   (collect (make-article :title title
				  :body body
				  :date date
				  :day (local-time:timestamp-day date)))))))

(defmethod initialize-instance :after ((p PAPER) &rest args)
  (declare (ignorable args))
  (setf (stp-> p)    (get-stp p)
	(bodies-> p) (funcall (bparser-> p) (stp-> p))
	(titles-> p) (funcall (tparser-> p) (stp-> p))
	(list-> p)   (make-articles p)))

(defun write-down-article (article op)
  (with-slots (title body) article
    (format op "** ~A~%" title)
    (format op "~{~A~%~%~}"
	    (mapcar #'string-fold body))))

(defgeneric write-down (paper daylist op))

(defmethod write-down ((paper PAPER) daylist op)
  (dolist (article (list-> paper))
    (if (member (article-day article) daylist :test #'equal)
	(write-down-article article op))))

(defun make-paper (suburl name)
  (make-instance 'PAPER
		 :url (format nil "http://shasetsu.seesaa.net/category/~A-1.html" suburl)
		 :name name
		 :body-parser #'ordinary-body-parser
		 :title-parser #'ordinary-title-parser))

(defun ordinary-initialize ()
  (mapcar (lambda (cons)
	    (destructuring-bind (name . sub) cons
	      (make-paper sub name)))
	  alist))

(defun this-month-date (day)
  (let ((today (local-time::today)))
    (make-date-literally day
			 (timestamp-month today)
			 (timestamp-year today))))

(defun make-akahata (day)
  (let ((date (this-month-date day)))
    (make-instance 'AKAHATA
		   :url (make-akahata-url date)
		   :date date
		   :coding :SJIS
		   :body-parser #'akahata-body-parser
		   :title-parser #'akahata-title-parser)))

(defmacro with-today (&body body)
  `(let ((today (today)))
     ,@body))

(defun this-month-basename ()
  (with-today
    (format nil "~A~2,'0d.org"
	    (timestamp-year today)
	    (timestamp-month today))))

(defun this-month-name ()
  (merge-pathnames topdir
		   (this-month-basename)))

(defun do-orgfile-output-port (func)
  (with-open-file (op (this-month-name)
		      :direction :output
		      :if-exists :append
		      :external-format #+sbcl :UTF8 #+clisp charset:utf-8)
    (funcall func op)))

(defun org-header-date (day op)
  (with-today
    (format op "* ~A/~A/~A~%"
	    (timestamp-year today)
	    (timestamp-month today)
	    day)))

(defun getnews (day &key (op nil))
  (do-orgfile-output-port
      (lambda (org-op)
	(let ((o (or op org-op)))
	  (org-header-date day o)
	  (iter (for x :in (ordinary-initialize))
		(write-down x (list day) o))
	  (write-down (make-akahata day) (list day) o)))))

