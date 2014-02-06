#lang racket

(define target (string->list "layer"))

;; [a], [a] -> bool
(define (perm-of w t)
  (let ((lenw (length w)) (lent (length t)))
    (and (= lenw lent)
         (or (= lenw 0) (let ((x (car w)) (xs (cdr w))) 
                          (and (member x t) (perm-of xs (remove x t))))))))

;; string, (string -> bool) -> (string -> void) -> void
(define (for-file-lines src test? handle)
  (call-with-input-file src 
    (λ (input-port)
      (define (aux)
        (let ((line (read-line input-port)))
          (if (eof-object? line) (void)
              (if (test? line) (begin (handle line) (aux)) (aux)))))
      (aux))))

;; string -> bool
(define (anagram? line) (perm-of (string->list line) target))
 
(time (for-file-lines "/usr/share/dict/words" anagram? display))