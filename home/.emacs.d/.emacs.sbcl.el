;; -*- mode:emacs-lisp -*-
;; (add-to-list 'load-path "~/site-lisp/slime")
(setq inferior-lisp-program "c:\\SBCL17\\sbcl.exe --no-inform")
;; (setq inferior-lisp-program "f:/clisp/clisp.exe -i f:/home/.clisprc")
(setq slime-net-coding-system 'utf-8-unix)
(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            (show-paren-mode)))
(setq slime-lisp-implementations
           `(;; (sbcl    (,(concat usb "SBCL1.1.4\\sbcl.exe")
	     ;; 		"--noinform"
	     ;; 		;; "--core" "f:\\sbcl.core-for-slime"
	     ;; 		))
	     ;; (sbcl    ("f:\\sbcl1.1.4\\sbcl.exe"
	     ;; 	       "--core" "f:\\sbcl1.1.4\\sbcl.core"
	     ;; 	       "--load" "f:\\home\\.sbcl12rc"))
	     (sbcl    ("c:\\sbcl17\\sbcl.exe"
	     	       "--core" "c:\\sbcl17\\sbcl.core"
	     	       "--load" "f:\\home\\.sbcl12rc"))
	     (clisp   (;; ,(concat usb "clisp\\clisp.exe")
		       "f:/clisp/clisp.exe"))
	     ;; (clojure ("c:\\windows\\system32\\java.exe" "-cp" "f:\\clojure-1.4.0\\clojure-1.4.0.jar" "clojure.main"))
	     (clojure ("f:\\home\\clojure.bat"))))
(setq lisp-indent-function 'common-lisp-indent-function
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq temporary-file-directory
      (cond
       ((file-exists-p "c:/users/honbu020.newnet/")
	 "c:\\users\\honbu020.NEWNET\\appdata\\local\\temp\\")
      	((file-exists-p "c:/users/honbu022.newnet/")
	 "c:\\users\\honbu022.NEWNET\\appdata\\local\\temp\\")
	((file-exists-p "c:/users/honbu115.newnet/")
	 "c:\\users\\honbu115.NEWNET\\appdata\\local\\temp\\")
	((file-exists-p "c:/users/honbu108.newnet/")
	 "c:\\users\\honbu108.NEWNET\\appdata\\local\\temp\\")
	((file-exists-p "c:/users/jumpei/")
	 "c:\\users\\jumpei\\appdata\\local\\temp\\")))

(require 'slime)
(slime-setup '(slime-banner slime-repl slime-fancy slime-asdf ;slime-sbcl-exts
	       slime-autodoc slime-hyperdoc))

