#lang racket
(provide (all-defined-out))

(define (write-text-to-file text path)
  (let ([outfile (open-output-file path #:mode 'text #:exists 'replace)])
    (begin
      (display text outfile)
      (close-output-port outfile)
      )))