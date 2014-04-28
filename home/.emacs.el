;; -*- coding:utf-8 -*-
;; イーマックス
(set-language-environment "Japanese")

(setq load-path (append '("~/site-lisp/ddskk/"
			  "~/site-lisp/clojure-mode/"
			  "~/site-lisp/mm-color/"
			  "~/site-lisp/helm/"
			  "~/site-lisp/mm-color/themes"
			  "~/site-lisp"
			  "~/site-lisp/auto-complete/"
			  "~/site-lisp/apel"
			  "~/site-lisp/cmigemo"
			  "~/site-lisp/navi2ch"
			  "~/.emacs.d/"
			  "~/my-lisp"
			  "~/Gauche/bin/"
			  "C:/Ruby200/bin"
			  "f:/home/.emacs.d/elpa/migemo-20140305.156/")
			load-path))

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(add-to-list 'process-coding-system-alist '("cmigemo" utf-8 . utf-8))
(load ".emacs.migemo")

(require 'package)
; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

; Initialize
(package-initialize)

(setenv "PATH"
        (concat "c:\\SBCL;f:\\cmigemo;f:\\w3m;" (getenv "PATH")))

(ffap-bindings)

(defvar usb
  (replace-regexp-in-string
   "/"
   "\\\\"
   usb-drive-letter))

(load ".emacs.sbcl")

(require 'skk)
(require 'skk-autoloads)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(setq skk-large-jisyo "~/SKK-JISYO.L")

(set-frame-parameter nil 'alpha 95)

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


(if window-system
(set-frame-font "Ricty Diminished-13.5")
;; (set-frame-font "ゆたぽん（コーディング）-13.5")
;;(set-frame-font "Consolas-13.5")
;; (set-frame-font "MS Gothic-13.5")
;; (set-frame-font "MS Mincho-13.5")
)
;; (set-frame-font "MS Gothic-12"))
;; 
;; (unless (tty-display-color-p)
;;   (set-fontset-font (frame-parameter nil 'font)
;; 		    'japanese-jisx0208
;; 		    (font-spec :family "Meiryo")
;; 		    ;; (font-spec :family "")
;; 		    ))

(defun select-theme (name)
  (load-theme name t)
  (enable-theme name))
;; (load-theme 'misterioso t)
(select-theme 'tango)
;; (select-theme 'tango-dark)
(select-theme 'pastels-on-dark)

(menu-bar-mode -1)
(tool-bar-mode -1)

;; DIRED
(load ".emacs.dired")

;;; FONT-LOCK
(global-font-lock-mode t)

;; ;;; MINIBUFFER
;; (setq resize-mini-windows nil)

;;; BACKUP
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/backup"))
	    backup-directory-alist))

;;; IMAGE
(auto-image-file-mode)

;;; CHANGE-DIRS
(cd "~/")

;;; PAREN-MODE
(setq show-paren-mode t)
(if window-system
    (progn
      (require 'mic-paren)
      (paren-activate)     ; activating
      (setq paren-match-face 'bold)
      (setq paren-sexp-mode t)))

;;; MOCCUR
(load "moccur")
(require 'color-moccur)
(load "moccur-edit")

(fset 'yes-or-no-p 'y-or-n-p)

(autoload 'word-count-mode "word-count"
  "Minor mode to count words." t nil)

;;; DABBREV
(require 'dabbrev)
(load "dabbrev-ja")
(require 'dabbrev-highlight)

(defun kill-whole-line ()
  (interactive)
  (if (= (point-at-eol) (point-max))
      (kill-region (point-at-bol) (point-at-eol))
    (kill-region (point-at-bol) (1+ (point-at-eol)))))

(defun skk-auto-fill-mode-minus (&optional arg)
  (interactive)
  (if (eq arg nil)
      (skk-mode)
    (skk-auto-fill-mode)))

(setq skk-isearch-start-mode 'latin)

(setq skk-dcomp-activate t)
(setq skk-show-inline nil)
(setq skk-show-annotation< t)
(setq skk-auto-okuri-process t)

(setq skk-sticky-key ";")
(require 'skk-annotation)
(require 'skk-sticky)
(setq enable-local-eval t) 

(defun zap-to-char (arg)
  (interactive "cZap to char: ")
  (let ((ch (char-to-string arg)))
    (condition-case err
	(progn
	  (kill-region (point)
		       (1- (re-search-forward (if (equal ch ".") "\\." ch) (point-at-eol) t nil)))
	  (backward-char 1))
      (error "Search Failed: " ch))))

(setq x-select-enable-clipboard t)

(setq eshell-history-size 30000)

(load-library ".emacs.key")

;; (require 'popup)
;; (require 'pos-tip)
;; (require 'popup-kill-ring)

;;; org-mode
(require 'org-install)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; ;;               *      
(setq org-hide-leading-stars t)
(setq org-directory "~/org/")
(setq org-default-notes-file "notes.org")

;; (setq org-agenda-files (list org-directory))
;; (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
;; (setq hl-line-face 'underline)
;; (setq calendar-holidays nil)
(load ".emacs.scheme-indent")
;; ;; (setq process-coding-system-alist (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
;; ;; (setq scheme-program-name "f:/Gauche0.9/bin/gosh.exe -i")
(setq process-coding-system-alist (cons '("gosh" sjis . sjis) process-coding-system-alist))
(add-to-list 'process-coding-system-alist '(utf-8 . utf-8))
(setq scheme-program-name "f:/Gauche/bin/gosh.exe -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(defun scheme-load-file ()
  (interactive)
  (let ((n (buffer-file-name)))
    (delete-other-windows)
    (split-window-below 30)
    (other-window 1)
    (unless (buffer-live-p (get-buffer "*scheme*"))
      (run-scheme scheme-program-name))
    (switch-to-buffer "*scheme*")
    (goto-char (point-max))
    (insert "(load \"" n "\")")
    (comint-send-input "")))
(add-hook 'scheme-mode-hook
	  (lambda ()
	   (define-key scheme-mode-map "\C-cx" 'scheme-load-file)))

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))
(add-hook 'scheme-mode-hook
	  (lambda ()
	   (define-key scheme-mode-map "\C-cs" 'scheme-other-window)))
;; ;; (setq explicit-shell-file-name "bash.exe")
;; ;; (setq shell-file-name "sh.exe")
;; ;; (setq shell-command-switch "-c")
;; ;; (set-language-environment "Japanese")
;; (set-default-coding-systems 'sjis-dos)
;; (set-keyboard-coding-system 'sjis-dos)
;; (set-terminal-coding-system 'sjis-dos)
;; (setq file-name-coding-system 'sjis-dos)
;; (set-clipboard-coding-system 'sjis-dos)
;; (set-w32-system-coding-system 'sjis-dos)
;; ;(mw32-ime-initialize)
;; (setq default-input-method "MW32-IME")
;; (set-cursor-color "#a0a0ff")
;; (add-hook 'mw32-ime-on-hook (lambda () (set-cursor-color "orange")))
;; (add-hook 'mw32-ime-off-hook (lambda () (set-cursor-color "#a0a0ff")))
;; (setq-default mw32-ime-mode-line-state-indicator "[cC]")
;; (setq mw32-ime-mode-line-state-indicator-list '("cC" "[  ]" "[cC]"))

(setq truncate-lines nil)

(load "kagofusen.el")

;; (load ".emacs.yatex")

(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)

;; ;; TODO    
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "BANKTODO(b)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; (setq org-log-done 'time)

;; (add-to-list 'load-path "~/site-lisp/rdtool/")
;; (autoload 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
;; (add-to-list 'auto-mode-alist '("\\.rd$" . rd-mode))
(add-hook 'ruby-mode-hook
 '(lambda ()
 (add-to-list 'ruby-encoding-map '(japanese-cp932 . cp932))
 (add-to-list 'ruby-encoding-map '(japanese-cp932-dos . cp932))
 (add-to-list 'ruby-encoding-map '(undecided . cp932))
 ))
;; (require 'ruby-electric)
;; (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
;; (autoload 'inf-ruby-setup-keybindings "inf-ruby" "" t)
;; (eval-after-load 'ruby-mode
;;   '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))

;; ;; (inf-ruby-switch-setup)



(setq-default default-coding-system 'sjis)

(coding-system-put 'sjis 'category 'sjis)
(set-language-info "Japanese" 'coding-priority
    (cons 'sjis
        (get-language-info "Japanese" 'coding-priority)))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'japanese-cp932-dos)

(modify-coding-system-alist 'file "\\.csv\\'" 'sjis)
;; ;;; js2.el
;; ;; (setq-default c-basic-offset 4)

;; ;; (when (load "js2" t)
;; ;;   (setq js2-cleanup-whitespace nil
;; ;;         js2-mirror-mode nil
;; ;;         js2-bounce-indent-flag nil)

;; ;;   (defun indent-and-back-to-indentation ()
;; ;;     (interactive)
;; ;;     (indent-for-tab-command)
;; ;;     (let ((point-of-indentation
;; ;;            (save-excursion
;; ;;              (back-to-indentation)
;; ;;              (point))))
;; ;;       (skip-chars-forward "\s " point-of-indentation)))
;; ;;   (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)

;; ;;   (define-key js2-mode-map "\C-m" nil)

;; ;;   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))
;; ;;;

;; (add-to-list 'file-coding-system-alist '("\\.lisp\\'" . utf-8))

;; (autoload 'cmd-mode "cmd-mode" "CMD mode." t)
;; (setq auto-mode-alist (append '(("\\.\\(cmd\\|bat\\)$" . cmd-mode))
;; 			      auto-mode-alist))

;; ;; Cygwin       
;; (setq dired-guess-shell-gnutar "tar")
;; (setq dired-guess-shell-alist-user
;;       '(("\\.tar\\.gz\\'"  "tar ztvf")
;;         ("\\.taz\\'" "tar ztvf")
;;         ("\\.tar\\.bz2\\'" "tar Itvf")
;;         ("\\.zip\\'" "unzip -l")
;;         ("\\.xls\\'" "excel.exe")
;;         ("\\.pdf\\'" "AcroRd32.exe")
;;         ("\\.\\(g\\|\\) z\\'" "zcat")
;;         ("\\.\\(jpg\\|JPG\\|gif\\|GIF\\)\\'"
;;          (if (eq system-type 'windows-nt)
;;              "fiber" "xv"))
;;         ("\\.ps\\'"
;;          (if (eq system-type 'windows-nt)
;;              "fiber" "ghostview"))
;;         ))

;; (when (require 'yaml-mode nil t)
;;   (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;;   (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

;; (auto-revert-mode)

;; (require 'multi-term)
;; (setq multi-term-program shell-file-name)

;; ;;(speedbar-add-supported-extension ".lisp")

;; (defun my-search-next-char (arg)
;;   (interactive "cchar: ")
;;   (let ((ch (char-to-string arg)))
;;     (condition-case err
;; 	(1- (re-search-forward (if (equal ch ".") "\\." ch) (point-at-eol) t nil))
;;       (error "Search Failed: " ch))))

;; (global-set-key (kbd "C-\\") 'my-search-next-char)

;; ;; (setq hl-line-face 'underline)
;; ;; (global-hl-line-mode)

;; ;; ace jump mode major function
;; ;; 
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-,") 'ace-jump-mode)

;; ;; 
;; ;; enable a more powerful jump back function from ace jump mode
;; ;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; (add-to-list 'load-path "f:/home/site-lisp/Caml/")
;; (add-to-list 'auto-mode-alist '("\\.ml[iylp]?$" . caml-mode))
;; (autoload 'caml-mode "caml" "Major mode for editing OCaml code." t)
;; (autoload 'run-caml "inf-caml" "Run an inferior OCaml process." t)
;; (autoload 'camldebug "camldebug" "Run ocamldebug on program." t)
;; (add-to-list 'interpreter-mode-alist '("ocamlrun" . caml-mode))
;; (add-to-list 'interpreter-mode-alist '("ocaml" . caml-mode))

;; ;; (if window-system (require 'caml-hilit))
;; (if window-system (require 'caml-font))


(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" 
  "Configuration of imenu for tuareg" t)

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))

(add-to-list 'load-path "~/site-lisp/fsharp/")
(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)
(setq process-coding-system-alist (cons '("Fsi" sjis . sjis) process-coding-system-alist))

(let* ((fsharp-bin "f:/FSharp/bin/")
       (fsi-command (concat fsharp-bin "Fsi"))
       (fsc-command (concat fsharp-bin "Fsc")))
  (setq inferior-fsharp-program fsi-command)
  (setq fsharp-compiler fsc-command))

(load "f:/home/site-lisp/powershell.el")

;; (add-hook 'lisp-mode-hook
;; 	  (lambda ()
;; 	    (hs-minor-mode 1)))

;; (setq process-coding-system-alist (cons '("ocaml" utf-8 . utf-8) process-coding-system-alist))
;; ;; (setq process-coding-system-alist (cons '("ocaml" utf-8 . utf-8) process-coding-system-alist))

;; (setq prolog-system 'swi)
;; (setq auto-mode-alist
;;       (append '(("\\.swi" . prolog-mode))
;;        auto-mode-alist))
;; (setq prolog-program-name "c:/swipl/bin/swipl.exe")

;; (add-to-list 'load-path "~/site-lisp/haskell-mode/")
;; (require 'haskell-mode-autoloads)
;; (setq haskell-program-name "c:/Haskell/bin/ghci.exe")
;; (add-to-list 'Info-default-directory-list "~/site-lisp/haskell-mode/")
;; (setq auto-mode-alist
;;       (append '(("\\.hs" . haskell-mode))
;;        auto-mode-alist))
;; (add-hook 'haskell-mode-hook '(lambda () (turn-on-haskell-indentation)))
;; (setq process-coding-system-alist (cons '("ghci" utf-8 . utf-8) process-coding-system-alist))

(require 'helm-config)
(require 'helm-migemo)
(require 'helm-command)

(global-set-key (kbd "C-c h") 'helm-mini)

(setq helm-idle-delay             0.1
      helm-input-idle-delay       0.1
      helm-candidate-number-limit 200)

(let ((key-and-func
       `((,(kbd "C-x b")   helm-for-files)
         (,(kbd "C-^")   comment-region)
         (,(kbd "C-;")   helm-resume)
         (,(kbd "M-s")   helm-occur)
         (,(kbd "M-x")   helm-M-x)
         (,(kbd "M-y")   helm-show-kill-ring)
         (,(kbd "C-M-z")   helm-do-grep)
        )))
  (loop for (key func) in key-and-func
        do (global-set-key key func)))

(helm-migemize-command helm-for-files)
(helm-migemize-command helm-show-kill-ring)
(helm-migemize-command helm-occur)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)

(defvar split-holizontally-alist
  '(("健康診断" "y:/23吉田/未処理/" "y:/22高嶋/特定健診処理済分/2013/")
    ("鍼灸送金" "d:/EB用フォルダ/柔整送信用フォルダ" "//Kkrfsv01/EB用フォルダ/鍼灸送信用フォルダ/2014年度")
    ("現給送金" "d:/EB用フォルダ/現金給付送信フォルダ" "//Kkrfsv01/EB用フォルダ/現金給付送信フォルダ/2014年度")))

(defun -split-holizontally (f1 f2)
  (delete-other-windows)
  (find-file f1)
  (split-window-below)
  (other-window 1)
  (find-file f2)
  (other-window 1))

(defun split-holizontally ()
    ;; (-split-holizontally win1 win2)
  (interactive)
  (helm :sources
	`((name . "helm split-holizontally")
	  (candidates . ,(mapcar #'car split-holizontally-alist))
	  (migemo)
	  (action . (lambda (sym)
		      (let* ((data (assoc sym split-holizontally-alist))
			     (win1 (second data))
			     (win2 (third data)))
			(-split-holizontally win1 win2)))))))

(global-set-key (kbd "M-$") 'split-holizontally)

(setq w3m-command "f:/w3m/w3m.exe")
(setq w3m-fill-column 80)
(require 'w3m)
(define-key w3m-mode-map (kbd "M-s") 'helm-occur)

(require 'ibuffer)

;; (require 'smooth-scroll)
;; (smooth-scroll-mode t)

(require 'kogiku)

;; (setq dynamic-library-alist
;;       '((xpm		"libXpm.dll")
;; 	(png		"libpng14-14.dll")
;; 	(jpeg		"libjpeg.dll")
;; 	(tiff		"libtiff.dll")
;; 	(gif		"giflib4.dll")
;; 	(svg		"librsvg-2-2.dll")
;; 	(gdk-pixbuf	"libgdk_pixbuf-2.0-0.dll")
;; 	(glib		"libglib-2.0-0.dll")
;; 	(gobject	"libgobject-2.0-0.dll")
;; 	(gnutls		"libgnutls-26.dll") ;
;; 	(libxml2	"libxml2.dll")))

(require 'smartchr)
(global-set-key (kbd "(")
		(smartchr '("(" "(`!!')" "(fun `!!' -> )" "(defun `!!' ())")))
(global-set-key (kbd "M")
		(smartchr '("M" "|> Seq.map (`!!')" "module " "module `!!' = ")))
(global-set-key (kbd "L") (smartchr '("L" "let `!!' = " "let `!!' = in")))
(global-set-key (kbd "I") (smartchr '("I" "|> Seq.iter (`!!')" "|> Seq.iter (printfn \"%A\")")))
(global-set-key (kbd "F") (smartchr '("F" "|> Seq.filter (`!!')")))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(navi2ch-article-message-filter-by-name-alist (quote (("ふみ ◆GU/3ByX.m. " . hide)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq explicit-shell-file-name "f:\\MinGW\\msys\\1.0\\bin\\bash.exe")
(put 'narrow-to-region 'disabled nil)

(turn-on-eldoc-mode)

(defadvice fsharp-show-subshell (after fsharp-other-window ())
  (other-window 1))
(ad-activate 'fsharp-show-subshell)

(setq scroll-conservatively 35
  scroll-margin 0
  scroll-step 1)

(require 'sr-speedbar)
(global-set-key (kbd "M-#") 'sr-speedbar-toggle)
(put 'upcase-region 'disabled nil)

(if (file-exists-p "c:/Program Files/Git/cmd/git.exe")
    (setq magit-git-executable "c:/Program Files/Git/cmd/git.exe")
    (setq magit-git-executable "c:/Program Files (x86)/Git/cmd/git.exe"))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'powerline)
(powerline-default-theme)
