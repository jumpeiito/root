;;; skk-macs.el --- macros and inline functions commonly used in SKK

;; Copyright (C) 1999, 2000 SKK Development Team <skk@ring.gr.jp>

;; Author: SKK Development Team <skk@ring.gr.jp>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Version: $Id: skk-macs.el,v 1.75 2001/12/16 05:03:10 czkmt Exp $
;; Keywords: japanese, mule, input method
;; Last Modified: $Date: 2001/12/16 05:03:10 $

;; This file is part of Daredevil SKK.

;; Daredevil SKK is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.

;; Daredevil SKK is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Daredevil SKK, see the file COPYING.  If not, write to
;; the Free Software Foundation Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; Code:

(eval-when-compile
  (defvar mule-version)
  (defvar skk-e21-modeline-property))

(eval-when-compile
  (require 'advice)
  (require 'static)
  (require 'skk-vars))

;;;; macros

(put 'ignore-errors 'defmacro-maybe t)
(defmacro-maybe ignore-errors (&rest body)
  "Execute FORMS; if an error occurs, return nil.
Otherwise, return result of last FORM."
  `((condition-case nil
	 (progn (,@ body))
       (error nil))))

(eval-and-compile
  (when (and (fboundp 'dolist)
	     (not (eval (macroexpand '(dolist (var nil t))))))
    ;; Old egg.el has invalid `dolist'.
    (fmakunbound 'dolist)))

;;;###autoload
(put 'dolist 'lisp-indent-function 1)
(put 'dolist 'defmacro-maybe t)
(defmacro-maybe dolist (spec &rest body)
  "(dolist (VAR LIST [RESULT]) BODY...): loop over a list.
Evaluate BODY with VAR bound to each car from LIST, in turn.
Then evaluate RESULT to get return value, default nil."
  (let ((temp (make-symbol "--dolist-temp--")))
    (list 'let (list (list temp (nth 1 spec)) (car spec))
	  (list 'while temp
		(list 'setq (car spec) (list 'car temp))
		(cons 'progn
		      (append body
			      (list (list 'setq temp (list 'cdr temp))))))
	  (if (cdr (cdr spec))
	      (cons 'progn
		    (cons (list 'setq (car spec) nil) (cdr (cdr spec))))))))

;;;###autoload
(put 'dotimes 'lisp-indent-function 1)
(put 'dotimes 'defmacro-maybe t)
(defmacro-maybe dotimes (spec &rest body)
  "(dotimes (VAR COUNT [RESULT]) BODY...): loop a certain number of times.
Evaluate BODY with VAR bound to successive integers running from 0,
inclusive, to COUNT, exclusive.  Then evaluate RESULT to get
the return value (nil if RESULT is omitted)."
  (let ((temp (make-symbol "--dotimes-temp--")))
    (list 'let (list (list temp (nth 1 spec)) (list (car spec) 0))
	   (list 'while (list '< (car spec) temp)
		 (cons 'progn
		       (append body (list (list 'setq (car spec)
						(list '1+ (car spec)))))))
	   (if (cdr (cdr spec))
	       (car (cdr (cdr spec)))
	     nil))))

(defmacro skk-defadvice (function &rest everything-else)
  (let ((origfunc (and (fboundp function)
		       (if (ad-is-advised function)
			   (ad-get-orig-definition function)
			 (symbol-function function))))
	interactive)
    (unless
	(or (not origfunc)
	    (not (subrp origfunc))
	    (memq function ; XXX possibilly Emacs version dependent
		  ;; built-in commands which do not have interactive specs.
		  '(abort-recursive-edit
		    bury-buffer
		    delete-frame
		    delete-window
		    exit-minibuffer)))
      ;; check if advice definition has a interactive call or not.
      (setq interactive
	    (cond
	     ((and (stringp (nth 1 everything-else)) ; have document
		   (eq 'interactive (car-safe (nth 2 everything-else))))
	      (nth 2 everything-else))
	     ((eq 'interactive (car-safe (nth 1 everything-else)))
	      (nth 1 everything-else))))
      (cond
       ((and (commandp origfunc)
	     (not interactive))
	(message "%s"
		 "\
*** WARNING: Adding advice to subr %s\
 without mirroring its interactive spec ***"
		 function))
       ((and (not (commandp origfunc))
	     interactive)
	(setq everything-else (delq interactive everything-else))
	(message
	 "\
*** WARNING: Deleted interactive call from %s advice\
 as %s is not a subr command ***"
	 function function))))
    (` (defadvice (, function) (,@ everything-else)))))

;;;###autoload
(put 'skk-defadvice 'lisp-indent-function 'defun)
(def-edebug-spec skk-defadvice defadvice)

(defmacro skk-save-point (&rest body)
  `((let ((skk-save-point (point-marker)))
       (unwind-protect
	   (progn (,@ body))
	 (goto-char skk-save-point)
	 (skk-set-marker skk-save-point nil)))))

(def-edebug-spec skk-save-point t)

(defmacro skk-message (japanese english &rest arg)
  ;; skk-japanese-message-and-error $B$,(B non-nil $B$@$C$?$i(B JAPANESE $B$r(B
  ;; nil $B$G$"$l$P(B ENGLISH $B$r%(%3!<%(%j%"$KI=<($9$k!#(B
  ;; ARG $B$O(B message $B4X?t$NBh#20z?t0J9_$N0z?t$H$7$FEO$5$l$k!#(B
  (append
   (if arg
       (list 'message (list 'if
			    'skk-japanese-message-and-error
			    japanese
			    english))
     (list 'message "%s" (list 'if
			       'skk-japanese-message-and-error
			       japanese
			       english)))
   arg))

(defmacro skk-error (japanese english &rest arg)
  ;; skk-japanese-message-and-error $B$,(B non-nil $B$@$C$?$i(B JAPANESE $B$r(B
  ;; nil $B$G$"$l$P(B ENGLISH $B$r%(%3!<%(%j%"$KI=<($7!"%(%i!<$rH/@8$5$;$k!#(B
  ;; ARG $B$O(B error $B4X?t$NBh#20z?t0J9_$N0z?t$H$7$FEO$5$l$k!#(B
  (append
   (if arg
       (list 'error (list 'if
			  'skk-japanese-message-and-error
			  japanese
			  english))
     (list 'error "%s" (list 'if
			     'skk-japanese-message-and-error
			     japanese
			     english)))
   arg))

(defmacro skk-yes-or-no-p (japanese english)
  ;; skk-japanese-message-and-error $B$,(B non-nil $B$G$"$l$P!"(Bjapanese $B$r(B
  ;; nil $B$G$"$l$P(B english $B$r%W%m%s%W%H$H$7$F(B yes-or-no-p $B$r<B9T$9$k!#(B
  ;; yes-or-no-p $B$N0z?t$N%W%m%s%W%H$,J#;($KF~$l9~$s$G$$$k>l9g$O$3$N(B
  ;; $B%^%/%m$r;H$&$h$j%*%j%8%J%k$N(B yes-or-no-p $B$r;HMQ$7$?J}$,%3!<%I$,(B
  ;; $BJ#;($K$J$i$J$$>l9g$,$"$k!#(B
  (list 'yes-or-no-p (list 'if 'skk-japanese-message-and-error
				   japanese english)))

(defmacro skk-y-or-n-p (japanese english)
  ;; skk-japanese-message-and-error $B$,(B non-nil $B$G$"$l$P!"(Bjapanese $B$r(B
  ;; nil $B$G$"$l$P(B english $B$r%W%m%s%W%H$H$7$F(B y-or-n-p $B$r<B9T$9$k!#(B
  (list 'y-or-n-p (list 'if 'skk-japanese-message-and-error
				japanese english)))

(defmacro skk-set-marker (marker position &optional buffer)
  ;; $B%P%C%U%!%m!<%+%kCM$G$"$k(B skk-henkan-start-point, skk-henkan-end-point,
  ;; skk-kana-start-point, $B$"$k$$$O(B skk-okurigana-start-point $B$,(B nil $B$@$C$?$i!"(B
  ;; $B?75,%^!<%+!<$r:n$C$FBeF~$9$k!#(B
  (list 'progn
	(list 'if (list 'not marker)
	      (list 'setq marker (list 'make-marker)))
	(list 'set-marker marker position buffer)))

;; From viper-util.el.  Welcome!
;;;###autoload
(put 'skk-deflocalvar 'lisp-indent-function 'defun)
(defmacro skk-deflocalvar (var default-value &optional documentation)
  `((progn
       (defvar (, var) (, default-value)
	       (, (format "%s\n\(buffer local\)" documentation)))
       (make-variable-buffer-local '(, var)))))

(defmacro skk-with-point-move (&rest form)
  ;; $B%]%$%s%H$r0\F0$9$k$,%U%C%/$r<B9T$7$F$[$7$/$J$$>l9g$K;H$&!#(B
  `((unwind-protect
	 (progn
	   (,@ form))
       (setq skk-previous-point (point)))))

(def-edebug-spec skk-with-point-move t)

(defmacro skk-face-on (object start end face &optional priority)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    `((let ((inhibit-quit t))
	 (if (not (extentp (, object)))
	     (progn
	       (setq (, object) (make-extent (, start) (, end)))
	       (if (not (, priority))
		   (set-extent-face (, object) (, face))
		 (set-extent-properties
		  (, object) (list 'face (, face) 'priority (, priority)))))
	   (set-extent-endpoints (, object) (, start) (, end))))))
   (t
    `((let ((inhibit-quit t))
	 (if (not (overlayp (, object)))
	     (progn
	       (setq (, object) (make-overlay (, start) (, end)))
	       (when (, priority)
		 (overlay-put (, object) 'priority (, priority)))
	       (overlay-put (, object) 'face (, face))
	       ;;(overlay-put (, object) 'evaporate t)
	       )
	   (move-overlay (, object) (, start) (, end))))))))

(defmacro skk-cannot-be-undone (&rest body)
  `((let ((buffer-undo-list t)
	   ;;buffer-read-only
	   (modified (buffer-modified-p)))
       (unwind-protect
	   (progn (,@ body))
	 (set-buffer-modified-p modified)))))

;;;###autoload
(put 'skk-loop-for-buffers 'lisp-indent-function 1)
(defmacro skk-loop-for-buffers (buffers &rest forms)
  `((save-current-buffer
       (dolist (buf (, buffers))
	 (when (buffer-live-p buf)
	   (set-buffer buf)
	   (,@ forms))))))

;;(defun-maybe mapvector (function sequence)
;; "Apply FUNCTION to each element of SEQUENCE, making a vector of the results.
;;The result is a vector of the same length as SEQUENCE.
;;SEQUENCE may be a list, a vector or a string."
;;  (vconcat (mapcar function sequence) nil))

;;(defun-maybe mapc (function sequence)
;;  "Apply FUNCTION to each element of SEQUENCE.
;;SEQUENCE may be a list, a vector, a bit vector, or a string.
;;-- NOT emulated enough, just discard newly constructed list made by mapcar --
;;This function is like `mapcar' but does not accumulate the results,
;;which is more efficient if you do not use the results."
;;  (mapcar function sequence)
;;  sequence)

;;;; INLINE FUNCTIONS.
;;; version dependent
(defsubst skk-sit-for (seconds &optional nodisplay)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (sit-for seconds  nodisplay))
   (t
    (sit-for seconds nil nodisplay))))

(defsubst skk-ding (&optional arg sound device)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
     (ding arg sound device))
    (t
     (ding arg))))

(defsubst skk-color-display-p ()
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (eq (device-class (selected-device)) 'color))
   ((fboundp 'x-display-color-p)
    ;; Emacs 19 or later.
    (and window-system (x-display-color-p)))))

(defsubst skk-str-length (str)
  ;; multibyte $BJ8;z$r(B 1 $B$H?t$($?$H$-$NJ8;zNs$ND9$5!#(B
  (static-cond
   ((eq skk-emacs-type 'mule2)
    (length (string-to-char-list str)))
   ((eq skk-emacs-type 'mule3)
    (length (string-to-vector str)))
   (t
    ;; XEmacs, MULE 4.0 or later.
    (length str))))

(defsubst skk-substring (str pos1 &optional pos2)
  ;; multibyte $BJ8;z$r(B 1 $B$H?t$($F(B substring $B$9$k!#(B
  (unless pos2
    (setq pos2 (skk-str-length str)))
  (static-cond
   ((eq skk-emacs-type 'mule2)
    (when (< pos1 0)
      (setq pos1 (+ (skk-str-length str) pos1)))
    (when (< pos2 0)
      (setq pos2 (+ (skk-str-length str) pos2)))
    (if (>= pos1 pos2)
	""
      (let ((sl (nthcdr pos1 (string-to-char-list str))))
	(setcdr (nthcdr (- pos2 pos1 1) sl) nil)
	(mapconcat 'char-to-string sl ""))))
   ((eq skk-emacs-type 'mule3)
    (when (< pos1 0)
      (setq pos1 (+ (skk-str-length str) pos1)))
    (when (< pos2 0)
      (setq pos2 (+ (skk-str-length str) pos2)))
    (if (>= pos1 pos2)
	""
      (let ((sl (nthcdr pos1 (string-to-char-list str))))
	(setcdr (nthcdr (- pos2 pos1 1) sl) nil)
	(concat sl))))
   (t
    ;; XEmacs, MULE 4.0 or later.
    (substring str pos1 pos2))))

(defsubst skk-char-to-string (char)
  (ignore-errors
    (char-to-string char)))

(defsubst skk-ascii-char-p (char)
  ;; CHAR $B$,(B ascii $BJ8;z$@$C$?$i(B t $B$rJV$9!#(B
  (static-cond
   ((eq skk-emacs-type 'mule2)
    ;; Can I use this for mule1?
    ;; (maybe < cz)
    (= (char-leading-char char) 0))
   (t
    ;; XEmacs, Emacs 20 or later.
    (eq (char-charset char) 'ascii))))

(defsubst skk-str-ref (str pos)
  (static-cond
   ((eq skk-emacs-type 'mule2)
    (nth pos (string-to-char-list str)))
   ((eq skk-emacs-type 'mule3)
    (aref (string-to-vector str) pos))
   (t
    ;; XEmacs, MULE 4.0 or later.
    (aref str pos))))

(defsubst skk-jisx0208-p (char)
  (static-cond
   ((eq skk-emacs-type 'mule2)
    ;; Can I use this for mule1?
    ;; (maybe < cz)
    (= (char-leading-char char) lc-jp))
   (t
    ;; XEmacs, MULE 3.0 or later.
    (eq (char-charset char) 'japanese-jisx0208))))

(defsubst skk-jisx0213-p (char)
  (and (featurep 'jisx0213)
       (memq (char-charset char)
	     '(japanese-jisx0213-1 japanese-jisx0213-2))))

(defsubst skk-char-octet (ch &optional n)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (or (nth (if n (1+ n) 1) (split-char ch))
	0))
   (t
    ;; FSF Emacs
    (char-octet ch n))))

;; this one is called once in skk-kcode.el, too.
(defsubst skk-charsetp (object)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (find-charset object))
   ((eq skk-emacs-type 'mule2)
    (character-set object))
   (t
    ;; MULE 3.0 or later.
    (charsetp object))))

(defsubst skk-indicator-to-string (indicator &optional no-properties)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (if (stringp indicator)
	indicator
      (cdr indicator)))
   ((eq skk-emacs-type 'mule5)
    (if no-properties
	(with-temp-buffer
	  (insert indicator)
	  (buffer-substring-no-properties (point-min) (point-max)))
      indicator))
   (t
    indicator)))

(defsubst skk-mode-string-to-indicator (mode string)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (cons (cdr (assq mode skk-xemacs-extent-alist))
	  string))
   ((memq skk-emacs-type '(mule5))
    (if (and window-system
	     (not (eq mode 'default)))
	(apply 'propertize string
	       (cdr (assq mode skk-e21-property-alist)))
      string))
   (t
    string)))

;;; This function is not complete, but enough for our purpose.
(defsubst skk-local-variable-p (variable &optional buffer afterset)
  "Non-nil if VARIABLE has a local binding in buffer BUFFER.
BUFFER defaults to the current buffer."
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (local-variable-p variable (or buffer (current-buffer)) afterset))
   ((fboundp 'local-variable-p)
    (local-variable-p variable (or buffer (current-buffer))))
   (t
    (and
     (or (assq variable (buffer-local-variables buffer)) ; local and bound.
	 (memq variable (buffer-local-variables buffer))); local but void.
     ;; docstring is ambiguous; 20.3 returns bool value.
     t))))

(defsubst skk-face-proportional-p (face)
  (static-cond
   ((fboundp 'face-proportional-p)
    (face-proportional-p face))
   (t
    nil)))

(defsubst skk-event-key (event)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (let ((tmp (event-key event)))
      (if (symbolp tmp)
	  (vector tmp)
	event)))
   (t
    (let ((char (event-to-character event))
	  keys)
      (if char
	  (vector char)
	(setq keys (recent-keys))
	(vector (aref keys (1- (length keys)))))))))

;;; version independent
(defsubst skk-cursor-set (&optional color force)
  (when (or skk-use-color-cursor
	    force)
    (skk-cursor-set-1 color)))

(defsubst skk-cursor-off ()
  (when skk-use-color-cursor
    (skk-cursor-off-1)))

(defsubst skk-modify-indicator-alist (mode string)
  (setcdr (assq mode skk-indicator-alist)
	  (cons string (skk-mode-string-to-indicator mode string))))

(defsubst skk-update-modeline (&optional mode string)
  (unless mode
    (setq mode 'default))
  ;;
  (when string
    (skk-modify-indicator-alist mode string))
  ;;
  (let ((indicator (cdr (assq mode skk-indicator-alist))))
    (setq skk-modeline-input-mode
	  (if (eq skk-status-indicator 'left)
	      (cdr indicator)
	    (car indicator)))
    (force-mode-line-update)))

;; $B%D%j!<$K%"%/%;%9$9$k$?$a$N%$%s%?!<%U%'!<%9(B
(defsubst skk-make-rule-tree (char prefix nextstate kana branch-list)
  (list char
	prefix
	(if (string= nextstate "")
	    nil
	  nextstate)
	kana
	branch-list))

;;(defsubst skk-get-char (tree)
;;  (car tree))
;;
;; skk-current-rule-tree $B$KBP$7$FGK2uE*$JA`:n$O9T$J$($J$$!#(Bskk-rule-tree $B$N(B
;; $BFbMF$^$GJQ$o$C$F$7$^$$!"(Bskk-current-rule-tree $B$N(B initialize $B$,<j7Z$K9T$J(B
;; $B$($J$/$J$k!#$3$3$,2r7h$G$-$l$P(B skk-prefix $B$rA4LG$G$-$k$N$K(B...$B!#(B
;;(defsubst skk-set-char (tree char)
;;  (setcar tree char))
;;
;;(defsubst skk-set-prefix (tree prefix)
;;  (setcar (cdr tree) prefix))

(defsubst skk-get-prefix (tree)
  (nth 1 tree))

(defsubst skk-get-nextstate (tree)
  (nth 2 tree))

(defsubst skk-set-nextstate (tree nextstate)
  (when (string= nextstate "")
    (setq nextstate nil))
  (setcar (nthcdr 2 tree) nextstate))

(defsubst skk-get-kana (tree)
  (nth 3 tree))

(defsubst skk-set-kana (tree kana)
  (setcar (nthcdr 3 tree) kana))

(defsubst skk-get-branch-list (tree)
  (nth 4 tree))

(defsubst skk-set-branch-list (tree branch-list)
  (setcar (nthcdr 4 tree) branch-list))

;; tree procedure for skk-kana-input.
(defsubst skk-add-branch (tree branch)
  (skk-set-branch-list tree (cons branch (skk-get-branch-list tree))))

(defsubst skk-select-branch (tree char)
  (assq char (skk-get-branch-list tree)))

(defsubst skk-erase-prefix (&optional clean)
  ;; skk-echo $B$,(B non-nil $B$G$"$l$P%+%l%s%H%P%C%U%!$KA^F~$5$l$?(B skk-prefix $B$r>C(B
  ;; $B$9!#%*%W%7%g%J%k0z?t$N(B CLEAN $B$,;XDj$5$l$k$H!"JQ?t$H$7$F$N(B skk-prefix $B$r(B
  ;; null $BJ8;z$K!"(Bskk-current-rule-tree $B$r(B nil $B=i4|2=$9$k!#(B
  ;;
  ;; $B$+$JJ8;z$NF~NO$,$^$@40@.$7$F$$$J$$>l9g$K$3$N4X?t$,8F$P$l$?$H$-$J$I$O!"%P%C(B
  ;; $B%U%!$KA^F~$5$l$F$$$k(B skk-prefix $B$O:o=|$7$?$$$,!"JQ?t$H$7$F$N(B skk-prefix $B$O(B
  ;; null $BJ8;z$K$7$?$/$J$$!#(B
  (when (and skk-echo
	     skk-kana-start-point
	     (not (string= skk-prefix ""))) ; fail safe.
    (let ((start (marker-position skk-kana-start-point)))
      (when start
	(condition-case nil
	    ;; skk-prefix $B$N>C5n$r%"%s%I%%$NBP>]$H$7$J$$!#(B
	    (skk-cannot-be-undone
	     (delete-region start (+ start (length skk-prefix))))
	  (error
	   (skk-set-marker skk-kana-start-point nil)
	   (setq skk-prefix ""
		 skk-current-rule-tree nil))))))
  (when clean
    (setq skk-prefix ""
	  skk-current-rule-tree nil))) ; fail safe

(defsubst skk-kana-cleanup (&optional force)
  (let ((data (cond
	       ((and skk-current-rule-tree
		     (null (skk-get-nextstate skk-current-rule-tree)))
		(skk-get-kana skk-current-rule-tree))
	       (skk-kana-input-search-function
		(car (funcall skk-kana-input-search-function)))))
	kana)
    (when (or force data)
      (skk-erase-prefix 'clean)
      (setq kana (if (functionp data)
		     (funcall data nil)
		   data))
      (when (consp kana)
	(setq kana (if skk-katakana
		       (car kana)
		     (cdr kana))))
      (when (stringp kana)
	(skk-insert-str kana))
      (skk-set-marker skk-kana-start-point nil)
      t)))

(defsubst skk-numeric-p ()
  (and skk-use-numeric-conversion
       (require 'skk-num)
       skk-num-list))

(defsubst skk-file-exists-and-writable-p (file)
  (and (setq file (expand-file-name file))
       (file-exists-p file)
       (file-writable-p file)))

(defsubst skk-lower-case-p (char)
  ;; CHAR $B$,>.J8;z$N%"%k%U%!%Y%C%H$G$"$l$P!"(Bt $B$rJV$9!#(B
  (and (<= ?a char)
       (>= ?z char)))

(defsubst skk-downcase (char)
  (or (cdr (assq char skk-downcase-alist))
      (downcase char)))

(defsubst skk-mode-off ()
  (setq skk-mode nil
	skk-abbrev-mode nil
	skk-latin-mode nil
	skk-j-mode nil
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana nil)
  ;; initialize
  (skk-update-modeline)
  (skk-cursor-off)
  (remove-hook 'pre-command-hook 'skk-pre-command 'local))

(defsubst skk-j-mode-on (&optional katakana)
  (setq skk-mode t
	skk-abbrev-mode nil
	skk-latin-mode nil
	skk-j-mode t
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana katakana)
  (skk-setup-keymap)
  (skk-update-modeline (if skk-katakana
			   'katakana
			 'hiragana))
  (skk-cursor-set))

(defsubst skk-latin-mode-on ()
  (setq skk-mode t
	skk-abbrev-mode nil
	skk-latin-mode t
	skk-j-mode nil
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana nil)
  (skk-setup-keymap)
  (skk-update-modeline 'latin)
  (skk-cursor-set))

(defsubst skk-jisx0208-latin-mode-on ()
  (setq skk-mode t
	skk-abbrev-mode nil
	skk-latin-mode nil
	skk-j-mode nil
	skk-jisx0208-latin-mode t
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana nil)
  (skk-setup-keymap)
  (skk-update-modeline 'jisx0208-latin)
  (skk-cursor-set))

(defsubst skk-abbrev-mode-on ()
  (setq skk-mode t
	skk-abbrev-mode t
	skk-latin-mode nil
	skk-j-mode nil
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; skk-abbrev-mode $B$O0l;~E*$J(B ascii $BJ8;z$K$h$kJQ49$J$N$G!"JQ498e$O85$N(B
	;; $BF~NO%b!<%I(B ($B$+$J%b!<%I$+%+%J%b!<%I(B) $B$KLa$k$3$H$,4|BT$5$l$k!#(B
	;; skk-katakana $B$O(B minor-mode $B%U%i%0$G$O$J$/!"(Bskk-j-mode $B%^%$%J!<%b!<%I(B
	;; $B$NCf$G$3$N%U%i%0$K$h$jF~NOJ8;z$r7hDj$9$k%]%$%s%?$rJQ99$9$k$@$1$J$N$G(B
	;; skk-abbrev-mode $B%^%$%J!<%b!<%I2=$9$k$N$K(B skk-katakana $B%U%i%0$r=i4|2=(B
	;; $B$7$J$1$l$P$J$i$J$$I,A3@-$O$J$$!#(B
	;; sub mode of skk-j-mode.
	;;skk-katakana nil
	)
  (skk-setup-keymap)
  (skk-update-modeline 'abbrev)
  (skk-cursor-set))

(defsubst skk-in-minibuffer-p ()
  ;; $B%+%l%s%H%P%C%U%!$,%_%K%P%C%U%!$+$I$&$+$r%A%'%C%/$9$k!#(B
  (eq (current-buffer) (window-buffer (minibuffer-window))))

(defsubst skk-insert-prefix (&optional char)
  ;; skk-echo $B$,(B non-nil $B$G$"$l$P%+%l%s%H%P%C%U%!$K(B skk-prefix $B$rA^F~$9$k!#(B
  (when skk-echo
    ;; skk-prefix $B$NA^F~$r%"%s%I%%$NBP>]$H$7$J$$!#A^F~$7$?%W%l%U%#%C%/%9$O!"(B
    ;; $B$+$JJ8;z$rA^F~$9$kA0$KA4$F>C5n$9$k$N$G!"$=$N4V!"(Bbuffer-undo-list $B$r(B
    ;; t $B$K$7$F%"%s%I%%>pJs$rC_$($J$/$H$bLdBj$,$J$$!#(B
    (skk-cannot-be-undone
     (insert-and-inherit (or char skk-prefix)))))

(defsubst skk-string<= (str1 str2)
  ;; STR1 $B$H(B STR2 $B$H$rHf3S$7$F!"(Bstring< $B$+(B string= $B$G$"$l$P!"(Bt $B$rJV$9!#(B
  (or (string< str1 str2)
      (string= str1 str2)))

(defsubst skk-do-auto-fill ()
  ;; auto-fill-function $B$KCM$,BeF~$5$l$F$$$l$P!"$=$l$r%3!<%k$9$k!#(B
  (when auto-fill-function
    (funcall auto-fill-function)))

(defsubst skk-current-input-mode ()
  (cond (skk-abbrev-mode 'abbrev)
	(skk-latin-mode 'latin)
	(skk-jisx0208-latin-mode 'jisx0208-latin)
	(skk-katakana 'katakana)
	(skk-j-mode 'hiragana)))

;;(defsubst skk-substring-head-character (string)
;;  (char-to-string (string-to-char string)))

(defsubst skk-get-current-candidate-1 ()
  (when (> 0 skk-henkan-count)
    (skk-error "$B8uJd$r<h$j=P$9$3$H$,$G$-$^$;$s(B"
	       "Cannot get current candidate"))
  ;; (nth -1 '(A B C)) $B$O!"(BA $B$rJV$9$N$G!"Ii$G$J$$$+$I$&$+%A%'%C%/$9$k!#(B
  (nth skk-henkan-count skk-henkan-list))

;; convert skk-rom-kana-rule-list to skk-rule-tree.
;; The rule tree follows the following syntax:
;; <branch-list>    ::= nil | (<tree> . <branch-list>)
;; <tree>         ::= (<char> <prefix> <nextstate> <kana> <branch-list>)
;; <kana>         ::= (<$B$R$i$,$JJ8;zNs(B> . <$B%+%?%+%JJ8;zNs(B>) | nil
;; <char>         ::= <$B1Q>.J8;z(B>
;; <nextstate>    ::= <$B1Q>.J8;zJ8;zNs(B> | nil

(defsubst skk-make-raw-arg (arg)
  (cond ((= arg 1) nil)
	((= arg -1) '-)
	((numberp arg) (list arg))))

(defsubst skk-unread-event (event)
  ;; Unread single EVENT.
  (setq unread-command-events
	(nconc unread-command-events (list event))))

(defsubst skk-get-last-henkan-datum (key)
  (cdr (assq key skk-last-henkan-data)))

(defsubst skk-put-last-henkan-datum (key val)
  (let ((e (assq key skk-last-henkan-data)))
    (if e
	(setcdr e val)
      (push (cons key val) skk-last-henkan-data))))

(defsubst skk-put-last-henkan-data (alist)
  (let (e)
    (dolist (kv alist)
      (if (setq e (assq (car kv) skk-last-henkan-data))
	  (setcdr e (cdr kv))
	(push (cons (car kv) (cdr kv))
	      skk-last-henkan-data)))))

(defsubst skk-find-coding-system (code)
  (cond ((and code
	      (or (and (fboundp 'coding-system-p)
		       (coding-system-p code))
		  (and (fboundp 'find-coding-system)
		       (symbolp code)
		       (find-coding-system code))))
	 code)
	((and code (stringp code))
	 (cdr (assoc code skk-coding-system-alist)))
	(t
	 (cdr (assoc "euc" skk-coding-system-alist)))))

(defsubst skk-lisp-prog-p (string)
  ;; STRING $B$,(B Lisp $B%W%m%0%i%`$G$"$l$P!"(Bt $B$rJV$9!#(B
  (let ((l (skk-str-length string)))
    (and (> l 2)
	 (eq (aref string 0) ?\()
	 ;; second character is ascii or not.
	 (skk-ascii-char-p (aref string 1))
	 (eq (skk-str-ref string (1- l)) ?\)))))

(defsubst skk-eval-string (string)
  ;; eval STRING as a lisp program and return the result.
  (let (func)
    ;; (^_^;) $B$N$h$&$JJ8;zNs$KBP$7!"(Bread-from-string $B$r8F$V$H(B
    ;; $B%(%i!<$K$J$k$N$G!"(Bcondition-case $B$G$=$N%(%i!<$rJa$^$($k!#(B
    (condition-case nil
	(setq func (car (read-from-string string)))
      (error
       (setq func string)))
    (ignore-errors
      (when (and (listp func)
		 (functionp (car func)))
	(setq string (eval func))))
    string))

;;;; from dabbrev.el.  Welcome!
;; $BH=Dj4V0c$$$rHH$9>l9g$"$j!#MW2~NI!#(B
(defsubst skk-minibuffer-origin ()
  (nth 1 (buffer-list)))

(defsubst skk-quote-char-1 (word alist)
  (mapconcat
   (function
    (lambda (char)
      (or (cdr (assq char alist))
	  (char-to-string char))))
   ;; $BJ8;zNs$rBP1~$9$k(B char $B$N%j%9%H$KJ,2r$9$k!#(B
   (append word nil) ""))

(defsubst skk-key-binding-member (key commands &optional map)
  (let (keys)
    (unless map
      (setq map skk-j-mode-map))
    (dolist (command commands)
      (setq keys (nconc keys
			(where-is-internal command map))))
    (member (key-description key)
	    (mapcar (function
		     (lambda (k)
		       (key-description k)))
		    keys))))

(require 'product)
(product-provide
    (provide 'skk-macs)
  (require 'skk-version))

;;; skk-macs.el ends here