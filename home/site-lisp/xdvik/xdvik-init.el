;; TeX source special $B$N$?$a$N@_Dj(B
(require 'xdvi-search) ; $BI,?\(B
(custom-set-variables
 '(server-switch-hook (quote (raise-frame)))) ; $BAk$r>e$K(B
(custom-set-faces)
(add-hook 'yatex-mode-hook
		  '(lambda ()
			 (define-key YaTeX-mode-map "\C-c\C-j" 'xdvi-jump-to-line)))
