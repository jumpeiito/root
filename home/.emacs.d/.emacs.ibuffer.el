(require 'ibuffer)

(setq ibuffer-never-show-regexps '("dvi" "messages" "Minibuf"
				   "Echo Area" "Completions" "migemo"))

(setq ibuffer-formats
      '((mark modified read-only " " (my-name 30 0)
	      " " (size 6 6) " " (mode 16 16) " " filename)
	(mark " " (name 30 0) " " filename))
      ibuffer-elide-long-columns t
      ibuffer-eliding-string "&")

(defun my-navi2ch-get-title (bname)
  (let ((curbuf (current-buffer)))
    (set-buffer bname)
    (setq title (cdr (assq 'subject navi2ch-article-current-article)))
    (set-buffer curbuf)
    title))

(defun ibuffer-w3m-get-title (bname)
  (w3m-buffer-title (get-buffer bname)))

(define-ibuffer-column
  my-name
  (:name "Name ")
  (cond
   ((string-match-p "navi2ch article" (buffer-name)) 
    (my-navi2ch-get-title (buffer-name)))
   ((string-match-p "w3m" (buffer-name)) 
    (ibuffer-w3m-get-title (buffer-name)))
   (t (buffer-name))))

(setq ibuffer-default-sorting-mode 'recency)

(defun ibuffer-visit-buffer-other-window-scroll (&optional down)
  (interactive)
  (let ((buf (ibuffer-current-buffer)))
    (unless (buffer-live-p buf)
      (error "Buffer %s has been killed!" buf))
    (if (string=
	 (buffer-name (window-buffer (next-window)))
	 (buffer-name buf))
	(if down
	    (scroll-other-window-down nil)
	  (scroll-other-window))
      (ibuffer-visit-buffer-other-window-noselect))))

(defun ibuffer-visit-buffer-other-window-scroll-down ()
  (interactive)
  (ibuffer-visit-buffer-other-window-scroll t))

;; (define-key ibuffer-mode-map " " 'ibuffer-visit-buffer-other-window-scroll)
;; (define-key ibuffer-mode-map "b" 'ibuffer-visit-buffer-other-window-scroll-down)

;; n, p で次 (前) のバッファの内容を表示する
(defadvice ibuffer-forward-line
  (after ibuffer-scroll-page activate)
  (ibuffer-visit-buffer-other-window-scroll))
(defadvice ibuffer-backward-line
  (after ibuffer-scroll-page-down activate)
  (ibuffer-visit-buffer-other-window-scroll-down))

;; ibuffer 検索
(defun Buffer-menu-grep-match (str)
  (interactive "P")
  (call-interactively 'ibuffer)
  (save-excursion
    (goto-char (point-min))
    (let (lines)
      (forward-line 2)
      (setq lines (buffer-substring (point-min) (point)))
      (while (re-search-forward str nil t)
	(let ((bol (progn (beginning-of-line) (point)))
	      (eol (progn (forward-line) (point))))
	  (setq lines (concat lines (buffer-substring bol eol)))))
      (let ((buffer-read-only nil))
	(erase-buffer)
	(insert lines)))))

(defun Buffer-menu-grep-reject (str)
  (interactive "P")
  (call-interactively 'ibuffer)
  (save-excursion
    (goto-char (point-min))
    (let (lines)
      (forward-line 2)
      (setq lines (buffer-substring (point-min) (point)))
      (forward-line 1)
      (while (re-search-forward ".+$" (line-end-position) t)
	(let ((bol (progn (beginning-of-line) (point)))
	      (eol (progn (forward-line) (point))))
	  (if (not (string-match str (buffer-substring bol eol)))
	      (setq lines (concat lines (buffer-substring bol eol))))))
      (let ((buffer-read-only nil))
	(erase-buffer)
	(insert lines)))))

(defun Buffer-menu-grep-tex ()
  (Buffer-menu-grep-match "tex"))

(defun Buffer-menu-grep-dired ()
  (Buffer-menu-grep-match "dired"))

(defun Buffer-menu-grep-text ()
  (Buffer-menu-grep-match "txt"))

;; (defun Buffer-menu-grep-2ch ()
;;   (Buffer-menu-grep-match "navi2ch"))

(defun Buffer-menu-grep-default ()
  (Buffer-menu-grep-reject "\\(texi\\|navi2ch\\)"))

(defvar my-buffer-menu-list '(("\.tex" . Buffer-menu-grep-tex)
			      ("dired" . Buffer-menu-grep-dired)
			      ("\.txt" . Buffer-menu-grep-text)
;			      ("\.el" . Buffer-menu-grep-el)
			      ("." . Buffer-menu-grep-default)
			      ))

(defun my-buffer-menu (arg)
  (interactive "P")
  (if arg
      ;;(call-interactively 'buffer-menu)
      (call-interactively 'ibuffer)
    (let ((alist my-buffer-menu-list)
	  (case-fold-search t)
	  (buffer-menu-com nil)
	  (name (buffer-name (current-buffer))))
      (while (and (not buffer-menu-com) alist)
	(if (string-match (car (car alist)) name)
	    (setq buffer-menu-com (cdr (car alist))))
	(setq alist (cdr alist)))
      (if buffer-menu-com
	  (funcall buffer-menu-com)
	(call-interactively 'ibuffer)))))

(global-set-key "\C-x\C-b" 'my-buffer-menu)

(defun Buffer-menu-grep-ext ()
  (let ((str (format "%s" (read-minibuffer "Input ext: "))))
    (Buffer-menu-grep-match str)))

(defun ibuffer-category ()
  (interactive)
  (message "T) eX  Te X) t  D) ired  A) ll  ...")
  (let ((c (downcase (char-to-string (read-char)))) (co))
    (cond
     ((string-match "t" c)
      (Buffer-menu-grep-tex))
     ((string-match "x" c)
      (Buffer-menu-grep-text))
     ((string-match "d" c)
      (Buffer-menu-grep-dired))
     ((string-match "a" c)
      (ibuffer))
     ;;      ((string-match "e" c)
     ;;       (Buffer-menu-grep-el))
     ;;      ((string-match "m" c)
     ;;       (Buffer-menu-grep-ext))
     (t
      (ibuffer-category)))))

(define-key ibuffer-mode-map "c" 'ibuffer-category)

;; ibufferを呼び出したときに自動更新
(defadvice ibuffer
  (after ibuffer-auto-update activate)
  (ibuffer-update 0))

(defun Buffer-menu-grep (str)                                    
  (interactive "sregexp:")                                       
  (goto-char (point-min))                                        
  (let (lines)                                                   
    (forward-line 2)                                             
    (setq lines (buffer-substring (point-min) (point)))          
    (while (re-search-forward str nil t)                         
      (let ((bol (progn (beginning-of-line) (point)))            
	    (eol (progn (forward-line) (point))))                
	(setq lines (concat lines (buffer-substring bol eol))))) 
    (let ((buffer-read-only nil))                                
      (erase-buffer)                                             
      (insert lines))))
(define-key Buffer-menu-mode-map "G" 'Buffer-menu-grep)

;; ----- ibufferの設定はここまで -----
