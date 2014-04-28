
;;; ANYTHING
(require 'anything-config)
(require 'anything)
(require 'anything-complete)
(require 'anything-match-plugin)
(require 'anything-migemo)
(setq anything-save-configuration-functions
      '(set-window-configuration . current-window-configuration))
(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0)
(setq anything-candidate-number-limit 100)
(setq anything-candidate-separator
      "------------------------------------------------------------------------------------")
(setq anything-persistent-action-use-special-display t)
(add-hook 'anything-after-persistent-action-hook 'which-func-update)
;; adaptive sort file is buggy
(remove-hook 'kill-emacs-hook 'anything-c-adaptive-save-history)
(setq anything-c-source-navi2ch-board
      '((name . "Navi2ch board")
	(init . (lambda () (require 'navi2ch)))
	(candidates
	 . (lambda () (mapcar (lambda (x) (cons (format "[%s]%s"
							(assoc-default 'id x 'eq)
							(assoc-default 'name x 'eq))
						(assoc-default 'id x 'eq)))
			      navi2ch-list-board-name-list)))
	(migemo)
	(action
	 ("goto" . (lambda (candidate)
		     (navi2ch-bm-select-board
		      (find candidate navi2ch-list-board-name-list
			    :test 'equal :key (lambda (x) (assoc-default 'id x)))))))))

(defun anything-music ()
  (directory-files (expand-file-name "~/dir/Music/") t ".*.flv\\|mp3"))

(defun anything-vimperator-history ()
  (split-string (shell-command-to-string "/home/jumpei/.emacs.d/vimperator-his.rb") "\n"))

(defun anything-shell-history ()
  (split-string (shell-command-to-string "cat /home/jumpei/.bash_history | uniq | tail -n 300") "\n"))

(defun anything-my-tv-program ()
  (split-string (shell-command-to-string "~/bin/Scheme/gettv.scm -e") "\n"))

(defun anything-browser-cache ()
  (split-string (shell-command-to-string "/usr/local/bin/gosh /home/jumpei/bin/Scheme/FLV.scm") "\n"))

(defun anything-cache-mplayer (can)
  (async-shell-command (concat "mplayer " can)))

(setq anything-c-source-browser-cache
      '(
	(name . "Browser Cache")
	(candidates . anything-browser-cache)
	(action 
	 . (("View with mplayer"
	     . (lambda (x) (anything-cache-mplayer x)))
	    ("Move to Desktop" 
	     . (lambda (x) 
		 (let ((fname (read-from-minibuffer "File Name: ")))
		   (shell-command (concat "mv " x " /home/jumpei/Desktop" (if (string= "" fname) "" (concat "/" fname ".flv")))))
		 ))))))

(defun anything-latex-im ()
  '("\\par\\medskip\\hfill"
    "最も適切なものを次から選び、記号で答えなさい。"
    "次の日本文の意味を表す英文になるように、()内の語句を並べかえなさい。"
    "日本文に合う英文になるように、(~~)内に適切な英語を書きなさい。"
    "ただし、同じ記号は他の空欄に入らないものとします"
    "次の各組の英文がほぼ同じになるように、(~~)に当てはまる語を書きなさい。"
    "意味の通る正しい英文になるように、(~~)内の語句を並べかえなさい。"
    "次の英文を日本文にしなさい。"
    "次の英文の(~~)内の語を、必要に応じて適切語に直しなさい。"
    "次の文章を読んで、後の問いに答えなさい。"
    "について次のようにまとめた。空らんに当てはまる言葉を答えなさい。"
    "本文中から\\rensuji{}字で抜き出しなさい。"
    "次の英文の下線部の意味を日本語で書きなさい。"
    "次の英文が正しい文になるように、()内から最も適当な語句を選んで書きなさい。"
    "次の英文を()内の指示にしたがって書きかえなさい。"
    "文章中の言葉を使って簡潔に答えなさい。"
    "文中から探し、その初めと終わりの\\rensuji{}字を書き抜きなさい。\\par\\medskip\\hfill"
    "次の文の空らんに当てはまる言葉を文章中からそれぞれ抜き出しなさい。\\par\\medskip"
    "の意味を次のようにまとめた。次の文の空らんに適当な語句を答えなさい。\\par\\medskip"
    ))

(setq anything-c-source-latex-input-method
      '(
	(name . "Latex Input")
	(migemo)
	(candidates . anything-latex-im)
	(action 
	 . (("Insert"
	     . (lambda (x) (insert x)))
	    ))))

(setq anything-c-source-tv-program
      '(
	(migemo)
	(name . "TV Program")
	(candidates . anything-my-tv-program)
	(action 
	 . (("" 
	     . (lambda (x) (anything-exit-minibuffer)))))))

(setq anything-c-source-vimperator-history
      '(
	(migemo)
	(name . "Vimperator History")
	(candidates . anything-vimperator-history)
	(action 
	 . (("Goto URL or search" 
	     . (lambda (m) 
		 (if (string-match "^http\\|file:///" m)
		     (async-shell-command (concat "firefox " m))
		   (async-shell-command (concat "firefox \"http://www.google.com/search?client=ubuntu&q=" m "&ie=utf-8&oe=utf-8\"")))))))))

(setq anything-c-source-my-shell-his
      '(
	(migemo)
	(name . "Shell History")
	(candidates . anything-shell-history)
	(action 
	 . (("Send Shell Buffer and Execute" 
	     . (lambda (m) 
		 (if (not (buffer-live-p "*shell*"))
		     (shell))
		 (switch-to-buffer "*shell*")
		 (goto-char (point-max))
		 ;; (move-beginning-of-line 1)
		 ;; (kill-line)
		 (insert m)
		 (comint-send-input)))))))

(setq anything-c-source-music
      '(
	(migemo)
	(name . "Music")
	(candidates . anything-music)
	(action 
	 . (("Play" . (lambda (m)
			(if (not (string= "" (shell-command-to-string "pgrep mplayer")))
			    (async-shell-command "pkill mplayer"))
			(async-shell-command (concat "mplayer \"" m "\""))))))))

(add-to-list 'anything-c-source-w3m-bookmarks '(migemo))
(setq anything-sources
      (list
	anything-c-source-navi2ch-board
	anything-c-source-w3m-bookmarks
	anything-c-source-my-shell-his
	anything-c-source-browser-cache
;	anything-c-source-vimperator-history
	anything-c-source-tv-program
	;; anything-c-source-music
	))

(add-to-list 'anything-c-source-info-gauche-refe
	     '(persistent-action . (lambda (c) (insert c))))
(defun anything-gauche-info ()
  (interactive)
  (anything '(anything-c-source-info-gauche-refe)))

(add-to-list 'anything-c-source-files-in-current-dir+ '(migemo))
(defun anything-buffers ()
  (interactive)
  (anything '(anything-c-source-buffers+
	      anything-c-source-files-in-current-dir+
	      anything-c-source-recentf)))

(defun anything-latex-input-methods ()
  (interactive)
  (anything '(anything-c-source-latex-input-method)))

;;; "Symbol's function definition is void " 対策
(defun which-func-update ())

(global-set-key "\C-c\C-j" 'anything-migemo)
(global-set-key "\C-cf" 'anything-buffers)
(global-set-key "\C-cj"    'anything-c-moccur-occur-by-moccur)
(define-key global-map (kbd "C-:") 'anything-top)
(eval-after-load 'yatex
  '(progn (define-key YaTeX-mode-map "\C-c:" 'anything-latex-input-methods)))

(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "[" 'anything-next-source)
(define-key anything-map "\M-v" 'anything-previous-page)
(define-key anything-map "]" 'anything-previous-source)
(define-key anything-map "\C-s" 'anything-isearch)
(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
(define-key anything-map "\C-i" 'anything-select-action)
(define-key anything-map "Q" 'anything-insert-buffer-name)
;; (define-key anything-map "R" 'anything-show/rubyref)
(define-key anything-map "@" 'anything-show/create)
(define-key anything-map "\C-k" 'anything-execute-persistent-action)
(define-key anything-map "\C-b" 'anything-backward-char-or-insert-buffer-name)
(define-key anything-map "\C-o" 'anything-next-source)

;; Automatically collect symbols by 150 secs
;; (anything-lisp-complete-symbol-set-timer 150)
;; (define-key emacs-lisp-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
;; (define-key lisp-interaction-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
;; replace completion commands with `anything'
;; (anything-read-string-mode 1)
;; Bind C-o to complete shell history
;; (anything-complete-shell-history-setup-key "\C-o")

(require 'anything-c-moccur)
(require 'anything-grep)
(setq moccur-use-migemo t)
(global-set-key "\C-x9" 'anything-c-moccur-occur-by-moccur)