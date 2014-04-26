    (setq ruby-keywords
          '("alias" "and" "begin" "break" "case" "catch" "class" "def" "do"
            "elsif" "else" "fail" "ensure" "for" "end" "if" "in" "module"
            "next" "not" "or" "raise" "redo" "rescue" "retry" "return" "then"
            "throw" "super" "unless" "undef" "until" "when" "while" "yield"
            ;; ^QRakefile keywords^P
            "task" "file" "desc" "rule"
            ;; ^Qelispunit / el4r keywords^P
            "def_test"
            ;; ^Qel4r keywords^P
            "defun"
            ;; ^Qasserts^P
            "assert_block" "assert_equal" "assert_in_delta" "assert_instance_of"
            "assert_kind_of" "assert_match" "assert_nil" "assert_no_match"
            "assert_not_equal" "assert_not_nil" "assert_not_same" "assert_nothing_raised"
            "assert_nothing_thrown" "assert_operator" "assert_raises" "assert_respond_to"
            "assert_same" "assert_send" "assert_throws" "assert"
            ;; ^Qrspec^P
            "context" "specify" "it"  "should" "should_not"
            ;; ^Qexpectations^P
            "expect"
            ;; other keywords 追加してください。
            "puts" "print"
            )
    ;;;;;
          ruby-highlight-keywords
          '("describe" "Expectations")
    ;;;;;
          ruby-font-lock-keywords
          (list
           ;; functions
           '("^\\s *def\\s +\\([^( \t\n]+\\)"
             1 font-lock-function-name-face)
           (cons (concat
                  "\\(^\\|[^_:.@$]\\|\\.\\.\\)\\b\\(defined\\?\\|\\("
                  (regexp-opt ruby-keywords)
                  "\\)\\>\\)")
                 2)
           `(,(concat
                  "\\(^\\|[^_:.@$]\\|\\.\\.\\)\\b\\("
                  (regexp-opt ruby-highlight-keywords)
                  "\\>\\)")
                 2 font-lock-warning-face prepend)
           ;; assignment
           ;; (regexp-opt '("=" "+=" "-=" "*=" "/=" "%=" "**=" "&=" "|=" "^=" "<<=" ">>=" "&&=" "||="))
           `("\\(?:&&\\|\\*\\*\\|<<\\|>>\\|||\\|[%&*+/|^-]\\)?=>?" 0 font-lock-warning-face)
           ;; xmpfilter
           '("# =>.*$" 0 font-lock-warning-face prepend)
           '(ruby-font-lock-xmpfilter-multi-line-annotation 0 font-lock-warning-face prepend)
           `(,(regexp-opt '(">=" "<=" "<=>" "==" "===" "!=" "=~")) 0 font-lock-builtin-face t)
           ;; variables
           '("\\(^\\|[^_:.@$]\\|\\.\\.\\)\\b\\(nil\\|self\\|true\\|false\\)\\>"
             2 font-lock-variable-name-face)
           ;; variables
           '("\\(\\$\\([^a-zA-Z0-9 \n]\\|[0-9]\\)\\)\\W"
             1 font-lock-variable-name-face)
           '("\\(\\$\\|@\\|@@\\)\\(\\w\\|_\\)+"
             0 font-lock-variable-name-face)
           ;; embedded document
           '(ruby-font-lock-docs
             0 font-lock-comment-face t)
           '(ruby-font-lock-maybe-docs
             0 font-lock-comment-face t)
           ;; ^Q"here" document^P
           '(ruby-font-lock-here-docs
             0 sh-heredoc-face t)
           '(ruby-font-lock-maybe-here-docs
             0 sh-heredoc-face t)
           `(,ruby-here-doc-beg-re
             0 sh-heredoc-face t)
           ;; general delimited string
           '("\\(^\\|[[ \t\n<+(,=]\\)\\(%[xrqQwW]?\\([^<[{(a-zA-Z0-9 \n]\\)[^\n\\\\]*\\(\\\\.[^\n\\\\]*\\)*\\(\\3\\)\\)"
             (2 font-lock-string-face t))
           ;; symbols
           '("\\(^\\|[^:]\\)\\(:\\([-+~]@?\\|[/%&|^`]\\|\\*\\*?\\|<\\(<\\|=>?\\)?\\|>[>=]?\\|===?\\|=~\\|\\[\\]=?\\|\\(\\w\\|_\\)+\\([!?=]\\|\\b_*\\)\\|#{[^}\n\\\\]*\\(\\\\.[^}\n\\\\]*\\)*}\\)\\)"
             2 font-lock-reference-face)
           ;; constants
           '("\\(^\\|[^_]\\)\\b\\([A-Z]+\\(\\w\\|_\\)*\\)"
             2 font-lock-type-face)
           ;; ^Qexpression expansion^P
           '("#\\({[^}\n\\\\]*\\(\\\\.[^}\n\\\\]*\\)*}\\|\\(\\$\\|@\\|@@\\)\\(\\w\\|_\\)+\\)"
             0 font-lock-reference-face t)
           ;; warn lower camel case
                                            ;'("\\<[a-z]+[a-z0-9]*[A-Z][A-Za-z0-9]*\\([!?]?\\|\\>\\)"
                                            ;  0 font-lock-warning-face)
           ;; ^Qeev hyperlink^P
           '("^ *#[^(\n]+\\((.*)\\)$" 1 ee-link-underline t)
         
           ))
