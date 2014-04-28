#!/usr/local/bin/gosh
(load "/home/jumpei/.gaucherc")

(define (mk-list)
  (map
   (lambda (x)
     (regexp-replace-all* ".+?value\":\"(?<match>.+?)\".+" x "\\k<match>"))
   (string-split 
    (read-file "/home/jumpei/.vimperator/info/default/history-command")
    ",")))

(define (main args)
  )