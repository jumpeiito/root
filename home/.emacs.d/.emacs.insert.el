;;; .emacs.insert.el --- 

;; Copyright (C) 2010  jumpei

;; Author: jumpei <jumpei@jumpei-VGN-TX93NS>
;; Keywords: 
;; テンプレートの保存先                  
(setq auto-insert-directory "~/insert/") 
(auto-insert-mode 1)                     
;; テンプレート挿入時に尋ねない          
;; デフォルトは 'function                
(setq auto-insert-query nil)             

(defun my-self-insert-tate-or-yoko (arg)
  (let ((pa (read-string "t)ate y)oko: ")))
    (if (> arg 0) (message "Please input \"t\" or \"y\""))
    (cond
     ((string= pa "t") "tarticle")
     ((string= pa "y") "jsarticle")
     (t (my-self-insert-tate-or-yoko 1)))))

(defvar self-my-insert-alist
  '(("a4" "760" "500")
    ("b4" "900" "560")
    ("b5" "620" "440")))

(defun self-my-insert-textheight (size)
  (nth 1 (assoc size self-my-insert-alist)))

(defun self-my-insert-textwidth (size)
  (nth 2 (assoc size self-my-insert-alist)))

(defun self-my-insert ()
  (insert
   (let ((psize (read-string "papersize: ")))
	  (concat
	  "\\documentclass[" psize "j]{"
	  (my-self-insert-tate-or-yoko 0) "}\n"
	  "\\usepackage{fancyhdr,palatino}\n"
	  "\\pagestyle{fancy}\n"
	  "\\topmargin-40pt\n"
	  "\\oddsidemargin-40pt\n"
	  "\\textheight" (self-my-insert-textheight psize) "pt\n"
	  "\\textwidth" (self-my-insert-textwidth psize) "pt\n"
	  "\\lhead{}\n"
	  "\\rhead{}\n"
	  "\\cfoot{}\n"
	  "\\columnseprule.4pt"
	  "\\headwidth=\\textwidth\n"
	  "\\begin{document}\n\n\\end{document}")))
  (previous-line))

 (self-my-insert)

(setq auto-insert-alist                                            (append
     '(
       (yatex-mode . self-my-insert))
     auto-insert-alist))
