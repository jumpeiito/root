(eval-when (:load-toplevel :compile-toplevel :execute)
  #+sbcl  (require :util)
  #+sbcl  (ql:quickload :closure-html)
  #+sbcl  (ql:quickload :drakma)
  #+clisp (ql:quickload :util)
  #+clisp (ql:quickload :closure-html))

(declaim (optimize (speed 3) (safety 0) (debug 0) (space 0) (compilation-speed 0)))

(defpackage #:news-base
  (:use :cl :util :iterate)
  (:export #:string-fold
	   #:topdir))

(in-package #:news-base)

(defparameter folding-length	34)
(defparameter topdir		"f:/Org/")
(defparameter terminal-char     '("。" "、" "ー" "」" ")" "）" "”"))
(defparameter starting-char	'("「" "(" "（" "“"))

(defun string-fold (string)
  (labels ((inner (subst r)
	     (if (>= folding-length (length subst))
		 (format nil "~{   ~A~^~%~}"
			 (if (string= subst "")
			     (reverse r)
			     (reverse (cons subst r))))
		 (let* ((flen  folding-length)
			(nextS (subseq subst flen (1+ flen)))
			(previous (subseq subst (1- flen) flen))
			(_flen
			 (cond
			   ((member nextS terminal-char :test #'equal)
			    (1+ flen))
			   ((member previous starting-char :test #'equal)
			    (1- flen))
			   (t flen))))
		   (inner (subseq subst _flen)
			  (cons (subseq subst 0 _flen) r))))))
    (inner string nil)))

(defpackage #:news-org
  (:use :cl :util :iterate)
  (:import-from #:local-time
		#:timestamp-year
		#:timestamp-month
		#:today)
  (:import-from #:news-base
		#:topdir)
  (:export #:with-today
	   #:this-month-name))

(in-package #:news-org)

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

(defpackage #:news-akahata
  (:use :cl :util :iterate)
  (:import-from #:local-time
		#:timestamp-year
		#:timestamp-month
		#:timestamp-day
		#:today)
  (:import-from #:xpath
		#:map-node-set->list
		#:string-value
		#:evaluate
		#:with-namespaces)
  (:import-from #:sb-ext
		#:octets-to-string)
  (:import-from #:drakma
		#:http-request)
  (:import-from #:news-base
		#:string-fold)
  (:import-from #:stp
		#:attribute-value
		#:find-child-if
		#:local-name))

(in-package :news-akahata)

(defparameter akahata-topurl "http://www.jcp.or.jp/akahata")
(defparameter akahata-suburl "aik14")

(defun make-akahata-url (day &key (page "index.html"))
  (format nil "~A/~A/~A-~2,'0d-~2,'0d/~A"
	  akahata-topurl
	  akahata-suburl
	  (timestamp-year day)
	  (timestamp-month day)
	  (timestamp-day day)
	  page))

(defun get-page (url)
  (octets-to-string (http-request url :external-format-in :dummy)
		    :external-format :SJIS))

(defun get-stp (url)
  (chtml:parse (get-page url) (stp:make-builder)))

(defun get-newslist-stp (day)
  (with-namespaces (("h" "http://www.w3.org/1999/xhtml"))
    (evaluate "//h:li[@class='newslist']"
	      (get-stp (make-akahata-url day)))))

(defun get-article-body (url)
  (with-namespaces (("h" "http://www.w3.org/1999/xhtml"))
    (remove-if-not
     (lambda (str) (and (not (string= "" str))
			(string= "　" (subseq str 0 1))))
     (map-node-set->list
      #'string-value
      (evaluate "//h:body//h:p"
		(get-stp url))))))

(defun string-modify (str)
  (string-fold (subseq str 1)))

(defstruct article node title url body)

(defun node-to-href-url (node)
  (attribute-value
   (find-child-if (lambda (stp) (equal "a" (local-name stp)))
		  node)
   "href"))

(defun create-article (day)
  (lambda (node)
    (let ((obj (make-article :node node)))
      (with-slots (node title url body) obj
	(setq title (string-value node)
	      url   (make-akahata-url day :page (node-to-href-url node))
	      body  (mapcar #'string-modify
			    (get-article-body url))))
      obj)))

(defun get-newslist (day)
  (map-node-set->list
   (create-article day)
   (get-newslist-stp day)))

(defun output (article op)
  (with-slots (title body) article
    (format op "** ~A~%" title)
    (format op "~{~A~^~%~%~}" body)
    (format op "~%")))

(defpackage #:news
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
  (:import-from #:news-base
		#:string-fold
		#:topdir)
  (:import-from #:news-org
		#:with-today
		#:this-month-name)
  (:import-from #:news-akahata
		#:get-newslist
		#:output)
  (:import-from #:util #:make-date-literally))

(in-package :news)

(defvar wget     "f:/UnxUtils/usr/local/wbin/wget.exe")
(defvar topurl   "http://shasetsu.seesaa.net/")
(defparameter encoding #+sbcl :SJIS #+clisp charset:shift-jis)
(defparameter newline-substitute "%%newline%%")
(defparameter alist
  '(("朝日" . "4848832")
    ("毎日" . "4848854")
    ("読売" . "4848855")
    ("日経" . "4848856")
    ("東京" . "4848858")
    ("産経" . "4848857")))

(defun make-url (papername)
  (format nil "~Acategory/~A-1.html"
	  topurl
	  (cdr (assoc papername alist :test #'equal))))

(defun make-local-name (papername)
  (format nil "~A/~A.html" topdir papername))

(defun download-url (papername)
  (format t "~A新聞をダウンロードします。~%" papername)
  #+sbcl
  (sb-ext:run-program wget `("-O"
			     ,(format nil "~A/~A.html" topdir papername)
			     ,(make-url papername))
		      :wait t)
  #+clisp
  (ext:run-shell-command
   (format nil "~A -O ~A/~A.html ~A"
	   wget topdir papername (make-url papername))))

(defun string-to-stp (string)
  (chtml:parse string (stp:make-builder)))

(defun read-file-list (papername)
  (call-with-input-file2 (make-local-name papername)
    (lambda (op)
      (iter (for c = (read-char op nil nil nil))
	    (when c
	      (collect c :into pot)
	      (next-iteration))
	    (leave pot)))
    :code encoding))

(defun read-file (papername)
  (regex-replace-all
   "<br />"
   (coerce (read-file-list papername)
	   'string)
   newline-substitute))

(defun documents (papername xpath)
  (with-namespaces (("h" "http://www.w3.org/1999/xhtml"))
    (evaluate
     xpath
     (string-to-stp (read-file papername)))))

(defun titles (papername)
  (map-node-set->list
   #'string-value
   (documents papername "//h:h3/h:a")))

(defun split-by-newline (string)
  (split newline-substitute string))

(defun node-string-split (node)
  (remove-if (lambda (line)
	       (or (string-null line)
		   (not (scan "。" line))))
	     (split-by-newline (string-value node))))

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

(defun bodies (papername)
  (map-node-set->list
   (lambda (node)
     (mapcar (compose #'string-fold
		      #'kill-last-space)
	     (node-string-split node)))
   (documents papername "//h:div[@class='text']")))


(defun parse-title (title)
  (register-groups-bind (paper core date)
      ("\\[(.+)新聞\\] (.+) \\((.+)\\)"
       title)
    (values paper core (strdt date))))

(defstruct newspaper date name title body coretitle weekday)

(defun create-newspaper (title body)
  (let ((obj (make-newspaper :title title :body body)))
    (with-slots (date name title body coretitle weekday) obj
      (multiple-value-bind (_paper _core _date)
	  (parse-title title)
	(setq date      _date
	      name      _paper
	      coretitle _core
	      weekday   (timestamp-day _date)))
      obj)))

(defun show-newspaper (news op)
  (with-slots (title body) news
    (format op "** ~A~%" title)
    (dolist (line body)
      (format op line)
      (format op "~%~%"))))

(defun show-today-newspaper (papername op)
  (mapc (lambda (news) (show-newspaper news op))
	(remove-if-not
	 (lambda (news)
	   (equal (timestamp-day (today))
		  (newspaper-weekday news)))
	 (newspapers papername))))

(defun show-this-day-newspaper (papername datelist op)
  (mapc (lambda (news) (show-newspaper news op))
	(remove-if-not
	 (lambda (news)
	   (member (newspaper-weekday news)
		   datelist))
	 (newspapers papername))))

(defun newspapers (papername)
  (mapcar #'create-newspaper
	  (titles papername)
	  (bodies papername)))

(defun get-paper (papername datelist op)
  (download-url papername)
  (show-this-day-newspaper papername datelist op))

(defun do-orgfile-output-port (func)
  (with-open-file (op (news-org:this-month-name)
		      :direction :output
		      :if-exists :append
		      :external-format :UTF8)
    (funcall func op)))

(defun org-header-date (day op)
  (with-today
    (format op "* ~A/~A/~A~%"
	    (timestamp-year today)
	    (timestamp-month today)
	    day)))

(defun this-date-newspaper (day op)
  (org-header-date day op)
  (iter (for (name . page) :in alist)
	(get-paper name (list day) op)))

(defun getNews (day &key (op nil))
  (with-today
    (let* ((year  (timestamp-year today))
	   (month (timestamp-month today))
	   (date  (make-date-literally day month year)))
      (do-orgfile-output-port
	  (lambda (output-port)
	    (let1 o (if op t output-port)
	      (this-date-newspaper day o)
	      (dolist (news (get-newslist date))
		(output news o))))))))
