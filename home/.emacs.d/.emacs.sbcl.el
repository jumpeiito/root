;; -*- mode:emacs-lisp -*-
(defvar sbcl-directory
  (or-exists "c:\\sbcl17\\" "f:\\sbcl1.1.4\\" "h:\\sbcl1.1.4\\"))
(defvar sbcl
  (concat sbcl-directory "sbcl.exe"))

(setq inferior-lisp-program (concat sbcl " --no-inform"))
;; (setq inferior-lisp-program "f:/clisp/clisp.exe -i f:/home/.clisprc")
(setq slime-net-coding-system 'utf-8-unix)
(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            (show-paren-mode)))

(setq slime-lisp-implementations
           `((sbcl    (,sbcl
	     	       "--core" ,(concat sbcl-directory "sbcl.core")
	     	       "--load" "f:\\home\\.sbcl12rc"))
	     (clisp   ("f:\\clisp\\clisp.exe"))
	     ;; (clojure ("c:\\windows\\system32\\java.exe" "-cp" "f:\\clojure-1.4.0\\clojure-1.4.0.jar" "clojure.main"))
	     (clojure ("f:\\home\\clojure.bat"))))
(setq lisp-indent-function 'common-lisp-indent-function
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq temporary-file-directory
      (let* ((user (user-login-name))
	     (post (if (string= user "Jumpei") "" ".newnet")))
      (concat "c:\\users\\" user post
	      "\\appdata\\local\\temp\\")))

(require 'slime)
(slime-setup '(slime-banner slime-repl slime-fancy slime-asdf ;slime-sbcl-exts
	       slime-autodoc slime-hyperdoc))

