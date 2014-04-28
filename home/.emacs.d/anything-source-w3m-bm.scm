#!/usr/local/bin/gosh
(load "/home/jumpei/.gaucherc")
(define myfile "/home/jumpei/.w3m/bookmark.html")

(define (mkw3mbm l)
  (for-each
   print
   (map
    (lambda (bookmark)
      (regexp-replace-all "<li><a href=\"(?<url>.+?)\">(?<title>.+?)</a>" bookmark "\\k<title>(\\k<url>)::\\k<url>"))
    (filter (lambda (line) (#/<li>/ line)) l))))

(define (main args)
  (mkw3mbm (string-split (read-file myfile) "\n")))