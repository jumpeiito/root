(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
	     howm-list-grep howm-create
	     howm-keyword-to-kill-ring))

;; ;; ��󥯤� TAB ��é��
 (eval-after-load "howm-mode"
   '(progn
      (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
      (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; ;; �ֺǶ�Υ��װ������˥����ȥ�ɽ��
(setq howm-list-recent-title t)
;; ;; �����������˥����ȥ�ɽ��
(setq howm-list-all-title t)
;; ;; ��˥塼�� 2 ���֥���å���
(setq howm-menu-expiry-hours 2)
;; ;; howm �λ��� auto-fill ��
(add-hook 'howm-mode-on-hook 'auto-fill-mode)
;; ;; RET �ǥե�����򳫤���, �����Хåե���ä�
;; ;; C-u RET �ʤ�Ĥ�
(setq howm-view-summary-persistent nil)
;; ;; ��˥塼��ͽ��ɽ��ɽ���ϰ�
;; ;; 10 ��������
(setq howm-menu-schedule-days-before 10)
; ;; 3 ����ޤ�
(setq howm-menu-schedule-days 3)

;; howm �Υե�����̾
;; �ʲ��Υ�������Τ����ɤ줫������Ǥ�������
;; �ǡ����פʹԤϺ�����Ƥ�������
;; 1 ��� 1 �ե����� (�ǥե����)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 �� 1 �ե�����Ǥ����
;(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
;
;(setq howm-view-grep-parse-line
;      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;;; �������ʤ��ե����������ɽ��
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; ���������ä��Τ����ݤʤΤ�
;; ���Ƥ� 0 �ʤ�ե����뤴�Ⱥ������
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
	  (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
	 (buffer-file-name (current-buffer))
	 (string-match "\\.howm" (buffer-file-name (current-buffer)))
	 (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c ����¸���ƥХåե��򥭥뤹��
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
	 (buffer-file-name)
	 (string-match "\\.howm"
		       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))

(defadvice find-file
  (after find-file-howm activate)
  (if (string-match "20.+\.howm" (buffer-name))
   (rd-mode)))

;;; conky��ɽ�����뤿��Υե������񤭽Ф��ؿ���
(setq my-conky-directory (expand-file-name "~/.conky/"))
(defun my-howm-conky-parse (buffer)
  "conky��ɽ�����뤿��Υե��������������"
  (set-buffer buffer)
  ;; ������ʬ�ν񤭴�����
  (goto-char (point-min))
  (while (re-search-forward "^> \\(.\\)[^|]+ | " nil t)
    (let ((week (match-string 1)))
      (replace-match "")
      (re-search-forward "20[0-9]+-\\([0-9]+-[0-9]+\\)" nil t)
      (replace-match (concat (match-string 1) "(" week ")"))))
  ;; �ֺѤߡפΤ�ΤϺ����
  (goto-char (point-min))
  (while (re-search-forward "\\[[^]]+].*}\\." nil t)
    (if (match-string 0)
        (progn
          (beginning-of-line)
          (let ((beg (point)))
            (forward-line)
            (delete-region beg (point)))))))

(defun my-howm-menu-internal (file func)
  "�������ؿ���
conky��ɽ�����뤿��Υե������񤭽Ф���"
  (save-excursion
    (message "%s" func)
    (set-buffer (find-file-noselect (concat my-conky-directory file)))
    (erase-buffer)
    (insert (encode-coding-string (funcall func) 'sjis))
    (my-howm-conky-parse (current-buffer))
    (save-buffer)
    (kill-buffer (current-buffer))))

(defun my-howm-menu-schedule ()
  "conky��ɽ�����뤿��Υե������񤭽Ф���"
  (let ((howm-menu-schedule-days-before 30)
        (howm-menu-schedule-days 90))
    (my-howm-menu-internal "schedule.txt" 'howm-menu-schedule)))

(defun my-howm-menu-todo ()
  "conky��ɽ�����뤿��Υե������񤭽Ф���"
  (let ((howm-menu-todo-num 30))
    (my-howm-menu-internal "todo.txt" 'howm-menu-todo)))

(defmacro my-howm-conky-string-paint (string color tag)
  "conky��color�����դ��ѥޥ���"
  `(concat "${" ,tag " " ,color "}" ,string "${" ,tag "}"))

;; (howm-menu)
;; (my-howm-menu-schedule)
;; (my-howm-menu-todo)

