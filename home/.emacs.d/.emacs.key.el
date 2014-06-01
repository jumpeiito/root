(load "term/bobcat")
(defun backward-kill-word-or-kill-region ()
  (interactive)
  (if (or (not transient-mark-mode) (region-active-p))
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(defun set-key ()
  (dolist (i `(("\C-h"	. backward-delete-char)
	       ("\C-w"  . backward-kill-word-or-kill-region)
	       ("\C-t"	. transpose-chars)
	       ("\C-x\C-b"	. ibuffer)
	       ("\C-^"	. comment-region)
	       ("\C-xp"	. replace-regexp)
	       ("\C-x:"	. org-remember)
	       ("\C-o"	. open-line)
	       ("\M-+"	. word-count-mode)
	       ("\M-y"	. kill-summary)
	       ("\C-cw"	. sdic-describe-word)          
	       ("\C-ch"	. lookup-region)          
	       ("\C-cW"	. sdic-describe-word-at-point) 
	       ("\C-xj"	. skk-auto-fill-mode-minus)
	       ("\C-cf"	. recentf-open-files)
	       ("\C-\M-j" . skk-undo-kakutei)
	       ("\M-k"	. kill-whole-line)
	       ("\M-o"	. dabbrev-expand)
	       ("\M-/"  . hippie-expand)
	       ("\M-n"	. zap-to-char)
	       ("\M-q"	. fill-paragraph)
	       ("\M-z"	. delete-horizontal-space)
	       ("\M-]"	. forward-paragraph)
	       ("\M-h"	. expand-abbrev)
	       ("\C-x\C-y"	. shell-toggle-cd)
	       ("\C-c\C-o" . bookmark-jump)
	       (,(kbd "<C-Up>") . (lambda () (interactive)
				   (text-scale-adjust 1)))
	       (,(kbd "<C-Down>") . (lambda () (interactive)
				   (text-scale-adjust -1)))
	       (,(kbd "<f12>") . toggle-viper-mode)
	       ("\C-cy" . (lambda () (interactive)
			    (popup-menu 'yank-menu)))
	       ("\C-c\C-i"   . (lambda () (interactive) 
				 (kmacro-insert-counter 1)))
	       ([f11]        . (lambda () (interactive) 
				 (cfw:open-calendar-buffer)))))
    (global-set-key (car i) (cdr i))))
(set-key)
(global-set-key "\C-x\C-y" 'eshell)

(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)

(defvar vm-key-alist
  '(("j" . (lambda () (interactive)
	     (next-line 1)
	     (recenter-top-bottom 0)))
    ("h" . 'backward-char)
    ("k" . (lambda () (interactive) 
	     (previous-line 1) 
	     (recenter-top-bottom 0)))
    ("l" . 'forward-char)
    ("n" . (lambda () (interactive)
	     (outline-next-visible-heading 1)
	     (recenter-top-bottom 0)))
    ("p" . (lambda () (interactive) 
	     (outline-previous-visible-heading 1)
	     (recenter-top-bottom 0)))))

(defmacro let1 (sym val &rest body)
  `(let ((,sym ,val))
     ,@body))

(defun insert-shebang-search ()
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "\\documentclass\\[.+?\\]")
    (replace-regexp-in-string
     ".+?\\[\\(.+?\\)\\].+"
     "\\1"
     (buffer-substring-no-properties (point-at-bol)
				     (point-at-eol)))))

(defun insert-shebang ()
  (interactive)
  (let1 parse (split-string (insert-shebang-search) ",")
	(let* ((paper (cond
		       ((member "b4j" parse) "b4")
		       ((member "a4j" parse) "a4")
		       ((member "b5j" parse) "b5")))
	       (land  (if (member "landscape" parse) 1 nil))
	       (tex   (replace-regexp-in-string ".+/" "./" (buffer-file-name)))
	       (dvi   (replace-regexp-in-string "\\.tex" ".dvi" tex)))
	  (save-excursion
	    (goto-char (point-min))
	    (insert
	     (concat "%#!"
	     	     "platex -kanji=utf8 " tex " && "
	     	     "platex -kanji=utf8 " tex " && "
	     	     "dvipdfmx -p " paper (if land " -l" " ") " -d 5 " dvi "\n")
	     )))))

(add-hook 'view-mode-hook
          (lambda ()
	    (dolist (i vm-key-alist)
	      (define-key view-mode-map (car i) (cdr i)))))

(add-hook 'yatex-mode-hook
          (lambda ()
	    (define-key YaTeX-mode-map "\C-xm" 'insert-shebang)))
