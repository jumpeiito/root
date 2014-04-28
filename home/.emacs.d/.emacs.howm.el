(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
	     howm-list-grep howm-create
	     howm-keyword-to-kill-ring))

;; ;; リンクを TAB で辿る
 (eval-after-load "howm-mode"
   '(progn
      (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
      (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; ;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; ;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; ;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)
;; ;; howm の時は auto-fill で
(add-hook 'howm-mode-on-hook 'auto-fill-mode)
;; ;; RET でファイルを開く際, 一覧バッファを消す
;; ;; C-u RET なら残る
(setq howm-view-summary-persistent nil)
;; ;; メニューの予定表の表示範囲
;; ;; 10 日前から
(setq howm-menu-schedule-days-before 10)
; ;; 3 日後まで
(setq howm-menu-schedule-days 3)

;; howm のファイル名
;; 以下のスタイルのうちどれかを選んでください
;; で，不要な行は削除してください
;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 日 1 ファイルであれば
;(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
;
;(setq howm-view-grep-parse-line
;      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
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
;; C-cC-c で保存してバッファをキルする
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

;;; conkyが表示するためのファイルを書き出す関数。
(setq my-conky-directory (expand-file-name "~/.conky/"))
(defun my-howm-conky-parse (buffer)
  "conkyが表示するためのファイルを整形する"
  (set-buffer buffer)
  ;; 曜日部分の書き換え。
  (goto-char (point-min))
  (while (re-search-forward "^> \\(.\\)[^|]+ | " nil t)
    (let ((week (match-string 1)))
      (replace-match "")
      (re-search-forward "20[0-9]+-\\([0-9]+-[0-9]+\\)" nil t)
      (replace-match (concat (match-string 1) "(" week ")"))))
  ;; 「済み」のものは削除。
  (goto-char (point-min))
  (while (re-search-forward "\\[[^]]+].*}\\." nil t)
    (if (match-string 0)
        (progn
          (beginning-of-line)
          (let ((beg (point)))
            (forward-line)
            (delete-region beg (point)))))))

(defun my-howm-menu-internal (file func)
  "下請け関数。
conkyが表示するためのファイルを書き出す。"
  (save-excursion
    (message "%s" func)
    (set-buffer (find-file-noselect (concat my-conky-directory file)))
    (erase-buffer)
    (insert (encode-coding-string (funcall func) 'sjis))
    (my-howm-conky-parse (current-buffer))
    (save-buffer)
    (kill-buffer (current-buffer))))

(defun my-howm-menu-schedule ()
  "conkyが表示するためのファイルを書き出す。"
  (let ((howm-menu-schedule-days-before 30)
        (howm-menu-schedule-days 90))
    (my-howm-menu-internal "schedule.txt" 'howm-menu-schedule)))

(defun my-howm-menu-todo ()
  "conkyが表示するためのファイルを書き出す。"
  (let ((howm-menu-todo-num 30))
    (my-howm-menu-internal "todo.txt" 'howm-menu-todo)))

(defmacro my-howm-conky-string-paint (string color tag)
  "conkyのcolorタグ付け用マクロ"
  `(concat "${" ,tag " " ,color "}" ,string "${" ,tag "}"))

;; (howm-menu)
;; (my-howm-menu-schedule)
;; (my-howm-menu-todo)

