;; TeX source special のための設定
(require 'xdvi-search) ; 必須
(custom-set-variables
 '(server-switch-hook (quote (raise-frame)))) ; 窓を上に
(custom-set-faces)
(add-hook 'yatex-mode-hook
		  '(lambda ()
			 (define-key YaTeX-mode-map "\C-c\C-j" 'xdvi-jump-to-line)))
