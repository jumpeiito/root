;; 新規取得のみ async。

(require 'navi2ch)

;; get async or not
(defvar navi2ch-async-get t)


(defvar navi2ch-async-process-buffer " *navi2ch async process*")

;; buffer-local な vectorにでもする？
(defvar navi2ch-async-process nil)
(defvar navi2ch-async-output-buffer nil)
(defvar navi2ch-async-status nil)	;navi2ch-net-status?
(defvar navi2ch-async-header nil)	;navi2ch-net-header?
(defvar navi2ch-async-first nil)
(defvar navi2ch-async-number nil)
(defvar navi2ch-async-filter-position nil)
(defvar navi2ch-async-gzip-p nil)

(defmacro navi2ch-async-net-ignore-errors (&rest body)
  "BODY を評価し、その値を返す。
BODY の評価中にエラーが起こると nil を返す。"
  `(condition-case err
       ,(cons 'progn body)
     (error
      (condition-case nil
	  (navi2ch-async-net-cleanup-process)
	(error nil))
      (ding)
      (if err
	  (message "Error: %s" (error-message-string err))
	(message "Error"))
      (sleep-for 1)
      nil)
     (quit
      (condition-case nil
	  (navi2ch-async-net-cleanup-process)
	(error nil))
      (signal (car err) (cdr err)))))

;;for debug
;; (defmacro navi2ch-async-net-ignore-errors (&rest body)
;;   "BODY を評価し、その値を返す。
;; BODY の評価中にエラーが起こると nil を返す。"
;;   `,(cons 'progn body))

(defun navi2ch-async-net-cleanup ()
  (navi2ch-async-net-cleanup-process)
  (navi2ch-async-net-cleanup-vars))

(defun navi2ch-async-net-cleanup-process ()
  (let ((proc navi2ch-async-process))
    (when (processp proc)
      (set-process-filter proc 'ignore)
      (set-process-sentinel proc 'ignore)
      (when (eq (process-status proc) 'open)
	(delete-process proc))
      (setq navi2ch-async-process nil))))

(defun navi2ch-async-net-cleanup-vars ()
  (setq navi2ch-async-status nil
	navi2ch-async-header nil
	navi2ch-async-first nil
	navi2ch-async-number nil
	navi2ch-async-filter-position nil
	navi2ch-async-gzip-p nil))

;; mew-filter
(defmacro navi2ch-async-filter (&rest body)
  `(let ((pbuf (process-buffer process)) ;; MUST use 'process'
	 (obuf (buffer-name)))
     (if (and (bufferp pbuf)
	      (buffer-name pbuf)) ;; check a killed buffer
	 ;; must use buffer-name instead of current-buffer
	 ;; so that get-buffer can detect killed buffer.
	 (unwind-protect
	     (progn
	       ;; buffer surely exists.
	       (set-buffer (process-buffer process)) ;; necessary
	       (navi2ch-async-net-ignore-errors ,@body))
	   (if (get-buffer obuf)
	       ;; the body sometimes kills obuf.
	       (set-buffer obuf))))))

(defun navi2ch-async-article-filter (process string)
  (navi2ch-async-filter
   (goto-char (point-max))
   (insert string)
   (if (null navi2ch-async-status)
       (navi2ch-async-get-header)
     (when (string= navi2ch-async-status "200")
       (navi2ch-async-article-insert-lines 10) ;xxx
       (when (and navi2ch-async-number
		  (buffer-live-p navi2ch-async-output-buffer))
	 (with-current-buffer navi2ch-async-output-buffer
	   (when (and (listp navi2ch-article-message-list)
		      (assq navi2ch-async-number navi2ch-article-message-list))
	     (navi2ch-article-goto-number navi2ch-async-number)
	     (setq navi2ch-async-number nil))))))))


(defun navi2ch-async-article-sentinel (process event)
  (cond
   ((and navi2ch-async-status
	 (string= navi2ch-async-status "200"))
    (let (cont)
      (navi2ch-async-filter
       (navi2ch-async-article-insert-lines)
       (setq cont (navi2ch-string-as-multibyte
		   (buffer-substring-no-properties
		    (progn
		      (goto-char (point-min))
		      (re-search-forward "\r\n\r?\n" nil t))
		    (point-max)))))
      (when (buffer-live-p navi2ch-async-output-buffer)
	(with-current-buffer navi2ch-async-output-buffer
	  (let* ((article navi2ch-article-current-article)
		 (board navi2ch-article-current-board)
		 (file (navi2ch-article-get-file-name board article))
		 (dir (file-name-directory file)))
	    (unless (file-exists-p dir)
	      (make-directory dir t))
	    (let ((coding-system-for-write 'binary)
		  (coding-system-for-read 'binary))
	      (with-temp-file file
		;;xxx
		(when (file-exists-p file)
		  (insert-file-contents file)
		  (goto-char (point-max)))
		(insert cont)))
	    (navi2ch-article-save-info board article navi2ch-async-first)
	    (run-hooks 'navi2ch-article-after-sync-hook)
	    (when navi2ch-async-number
	      (navi2ch-article-goto-number navi2ch-async-number))
	    (navi2ch-article-set-summary-element board article nil)))))
    (message "inserting current messages...done"))
   (t
    (message "Async の機能不足です。ｽﾏｿ")
    (let ((navi2ch-async-get nil))
      (when (buffer-live-p navi2ch-async-output-buffer)
	(with-current-buffer navi2ch-async-output-buffer
	  (unless (listp navi2ch-article-message-list)
	    (setq navi2ch-article-message-list nil))
	  (navi2ch-article-sync))))))
  (navi2ch-async-net-cleanup))

(defun navi2ch-async-article-sync (&optional force first number)
  "スレを更新する。force なら強制。
first が nil ならば、ファイルが更新されてなければ何もしない"
  (interactive "P")
  (when (not (navi2ch-board-from-file-p navi2ch-article-current-board))
    (run-hooks 'navi2ch-article-before-sync-hook)
    (let* ((article navi2ch-article-current-article)
           (board navi2ch-article-current-board)
           (navi2ch-net-force-update (or navi2ch-net-force-update
                                         force))
           (file (navi2ch-article-get-file-name board article))
           header)
      (when first
        (setq article (navi2ch-article-load-info)
	      navi2ch-article-message-list
	      (navi2ch-article-get-message-list file)))
      (navi2ch-article-set-mode-line)
      (if (and (cdr (assq 'kako article))
	       (file-exists-p file)
	       (not (and force ; force が指定されない限りsyncしない
			 (y-or-n-p "re-sync kako article?"))))
	  (setq navi2ch-article-current-article article)
	(setq navi2ch-async-output-buffer (current-buffer)
	      navi2ch-async-number (or number (cdr (assq 'number article)))
	      navi2ch-async-first first
	      ;; navi2ch-async-output-buffer が消されないように。
	      ;; see navi2ch-article-view-article()
	      navi2ch-article-message-list 'async)
	(navi2ch-async-article-update-file board article force))
      (setq navi2ch-article-hide-mode nil
	    navi2ch-article-important-mode nil))
    t					;for board-mode state
    ))

(defun navi2ch-async-article-update-file (board article force)
  (if navi2ch-offline
      (unless (listp navi2ch-article-message-list)
	(setq navi2ch-article-message-list nil))
    (if navi2ch-async-process
	(message "Another process is running.")
      (message "inserting current messages...")
      (setq navi2ch-article-view-range nil) ;display all in async
      (let* ((article navi2ch-article-current-article)
	     (board navi2ch-article-current-board)
	     (process-connection-type nil)
	     (inherit-process-coding-system
	      navi2ch-net-inherit-process-coding-system)
	     (url (navi2ch-article-get-url board article))
	     (list (navi2ch-net-split-url url navi2ch-net-http-proxy))
	     (host (cdr (assq 'host list)))
	     (file (cdr (assq 'file list)))
	     (port (cdr (assq 'port list)))
	     (host2ch (cdr (assq 'host2ch list)))
	     (pbuf (get-buffer-create navi2ch-async-process-buffer))
	     proc)
	(save-excursion
	  (set-buffer pbuf)
	  (erase-buffer)
	  (setq navi2ch-async-status nil
		navi2ch-async-header nil)
	  (navi2ch-set-buffer-multibyte nil))
	(message "now connecting...")
	(setq proc (open-network-stream "navi2ch-async-test" pbuf host port))
	(message "%sdone" (current-message))
	(process-kill-without-query proc)
	(set-process-coding-system proc 'binary 'binary)
	(set-process-filter proc 'navi2ch-async-article-filter)
	(set-process-sentinel proc 'navi2ch-async-article-sentinel)
	(message "sending request...")
	(process-send-string proc
			     (format (concat
				      "%s %s %s\r\n"
				      "MIME-Version: 1.0\r\n"
				      "Host: %s\r\n"
				      "Pragma: no-cache\r\n"
				      "User-Agent: " navi2ch-net-user-agent
				      "\r\n"
				      "\r\n")
				     "GET" file "HTTP/1.0" host2ch))
	(message "%sdone" (current-message))
	(setq navi2ch-async-process proc)))))

(define-key navi2ch-global-map "\C-c\C-k" 'navi2ch-async-process-stop)
(defun navi2ch-async-process-stop ()
  (interactive)
  (if (not (processp navi2ch-async-process))
      (message "No process is running.")
    (navi2ch-async-net-cleanup)
    (message "Process is stopped.")))

;; 新規取得のみ async。
(defadvice navi2ch-article-sync (around async-sync activate)
  (if (or (not navi2ch-async-get)
	  force				;C-u s in article-mode
	  (cdr (assq 'kako navi2ch-article-current-article)) ;kako
	  (not (eq (cdr (assq 'bbstype navi2ch-article-current-board))
		   'unknown))		;2ch
	  (file-exists-p (navi2ch-article-get-file-name
			  navi2ch-article-current-board
			  navi2ch-article-current-article)))
      ad-do-it
    (setq ad-return-value
	  (navi2ch-async-article-sync force first number))))

;; If navi2ch-article-view-article's arg NUMBER is specified,
;; (setq navi2ch-article-message-list 'async) causes error
;; in navi2ch-article-goto-number.
(defadvice navi2ch-article-goto-number (around async-hack activate)
  "Bind `navi2ch-article-message-list' to nil when async."
  (let ((navi2ch-article-message-list (and (listp navi2ch-article-message-list)
					   navi2ch-article-message-list)))
    ad-do-it))

;; ちょこっと変更。
(defun navi2ch-async-get-header ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "\r\n\r?\n" nil t)
      (let ((end (match-end 0))
	    list)
	(goto-char (point-min))
	;; get-status
	(when (looking-at "HTTP/1\\.[01] \\([0-9]+\\)")
	  (setq navi2ch-async-status (match-string 1)))
	(while (re-search-forward "^\\([^\r\n:]+\\): \\(.+\\)\r\n" end t)
	  (setq list (cons (cons (match-string 1) (match-string 2))
			   list)))
	(let ((date (assoc-ignore-case "Date" list)))
	  (when (and date (stringp (cdr date)))
	    (setq navi2ch-net-last-date (cdr date))))
	(when (buffer-live-p navi2ch-async-output-buffer)
	  (with-current-buffer navi2ch-async-output-buffer
	    (setq navi2ch-article-current-article
		  (navi2ch-put-alist 'time
				     (or (cdr (assoc "Last-Modified" list))
					 (cdr (assoc "Date" list)))
				     navi2ch-article-current-article))))
	(setq navi2ch-async-header (nreverse list))
	(setq navi2ch-async-filter-position end)))))


;; navi2ch-article-get-message-list
(defun navi2ch-async-article-get-message-list-buffer (dat)
  (let ((board navi2ch-article-current-board)
	(sep navi2ch-article-separator)
	(i (1+ (if (listp navi2ch-article-message-list)
		   (length navi2ch-article-message-list)
		 0)))
	message-list)
    (with-temp-buffer
      (insert dat)
      (decode-coding-region (point-min) (point-max) navi2ch-coding-system)
      (goto-char (point-min))
      (unless sep
	(setq sep (navi2ch-article-get-separator)))
      (goto-char (point-min))
      (while (not (eobp))
	(setq message-list
	      (cons (cons i
			  (let ((str (buffer-substring-no-properties
				      (point)
				      (progn (forward-line 1)
					     (1- (point))))))
			    (unless (string= str "") str)))
		    message-list))
	(setq i (1+ i))))
    (unless navi2ch-article-separator
      (setq navi2ch-article-separator sep)) ; it's a buffer local variable...
    (nreverse message-list)))

(defun navi2ch-async-article-insert-lines (&optional num)
  (when (buffer-live-p navi2ch-async-output-buffer)
    (save-excursion
      (goto-char navi2ch-async-filter-position)
      (when (> (- (buffer-size) (forward-line (buffer-size))) (or num 0))
	(beginning-of-line)
	(let ((dat (navi2ch-string-as-multibyte
		    (buffer-substring-no-properties
		     navi2ch-async-filter-position (point))))
	      mlist)
	  (setq navi2ch-async-filter-position (point))
	  (set-buffer navi2ch-async-output-buffer)
	  (save-excursion
	    (setq mlist (navi2ch-async-article-get-message-list-buffer dat)
		  navi2ch-article-message-list
		  (append (and (listp navi2ch-article-message-list)
			       navi2ch-article-message-list)
			  mlist))
	    (when (listp navi2ch-article-message-list)
	      ;; navi2ch-article-current-article は subject を持ってないかも。
	      (unless (cdr (assq 'subject navi2ch-article-current-article))
		(let ((msg (cdr (car navi2ch-article-message-list))))
		  (setq navi2ch-article-current-article
			(navi2ch-put-alist
			 'subject
			 (cdr (assq 'subject
				    (if (stringp msg)
					(navi2ch-article-parse-message msg)
				      msg)))
			 navi2ch-article-current-article))))
	      (let ((buffer-read-only nil))
		(goto-char (point-max))
		(navi2ch-async-article-insert-messages mlist nil))
	      (navi2ch-article-set-mode-line))))))))

;; message 出さないようにしただけ。
(defun navi2ch-async-article-insert-messages (list range)
  "LIST を整形して挿入する"
;;  (message "inserting current messages...")
  (let ((len (length list))
        (hide (cdr (assq 'hide navi2ch-article-current-article)))
        (imp (cdr (assq 'important navi2ch-article-current-article))))
    (dolist (x list)
      (let ((num (car x))
            (alist (cdr x)))
        (when (and alist
		   (cond (navi2ch-article-hide-mode
			  (memq num hide))
			 (navi2ch-article-important-mode
			  (memq num imp))
			 (t
			  (and (navi2ch-article-inside-range-p num range len)
			       (not (memq num hide))))))
          (when (stringp alist)
            (setq alist (navi2ch-article-parse-message alist)))
	  (let (filter-result)
	    (setq filter-result
		  (let ((filtered (navi2ch-article-apply-message-filters alist)))
		    (when filtered
		      (cond ((stringp filtered)
			     (navi2ch-put-alist 'name filtered alist)
			     (navi2ch-put-alist 'data filtered alist)
			     (navi2ch-put-alist 'mail
						(if (string-match "sage"
								  (cdr (assq 'mail alist)))
						    "sage"
						  "")
						alist))
			    ((eq filtered 'hide)
			     'hide)
			    ((eq filtered 'important)
			     'important)))))
	    (if (and (eq filter-result 'hide)
		     (not navi2ch-article-hide-mode))
		(progn
		  (setq hide (cons num hide))
		  (setq navi2ch-article-current-article
			(navi2ch-put-alist 'hide
					   hide
					   navi2ch-article-current-article)))
	      (when (and (eq filter-result 'important)
			 (not navi2ch-article-important-mode))
		    (setq imp (cons num imp))
		    (setq navi2ch-article-current-article
			  (navi2ch-put-alist 'important
					     imp
					     navi2ch-article-current-article)))
	      (setcdr x (navi2ch-put-alist 'point (point-marker) alist))
	      ;; (setcdr x (navi2ch-put-alist 'point (point) alist))
	      (navi2ch-article-insert-message num alist))))))
;;    (garbage-collect) ; navi2ch-parse-message は大量にゴミを残す
;;    (message "inserting current messages...done")))
    ))

(provide 'navi2ch-async)

;;; navi2ch-async.el ends here
