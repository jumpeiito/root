#!/usr/local/bin/gosh.scm

(load "/home/jumpei/.gaucherc")
(define *history* "/home/jumpei/.bash_history")
(define *size* 100)

(define (list-uniq l)
  (let loop ((subl l) (r '()))
    (if (null? subl)
        (reverse r)
        (loop (cdr subl) (if (member (car subl) r)
                             r
                             (cons (car subl) r))))))

(define (sh-his-make-list)
  (let ((l (string-split (read-file *history*) "\n")))
  (list-uniq
   (list-tail
    l
    (if (< (length l) *size*) 0 *size*)))))

(define (main args)
  (for-each print (sh-his-make-list)))
