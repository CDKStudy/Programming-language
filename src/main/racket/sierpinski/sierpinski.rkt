#lang racket
(require 2htdp/image)
(require "../spacer/spacer.rkt")
(provide (all-defined-out))

; Dekang Cao
(define (sierpinski-triangle side-length n)
(if (= n 0)
  (triangle side-length 'solid 'blue)
  (let* ((t2 (sierpinski-triangle (/ side-length 2) (- n 1)))
        (top t2)
        (left t2)
        (right t2)
        (bottom (beside left right )))(above top bottom))))

; Define a function to create a Sierpiński Carpet
(define (square side-length color)
(rectangle side-length side-length 'solid color))
(define (sierpinski-carpet side-length n)
(if (= n 0)
  (square side-length "orange")
  (let* ((c2 (/ side-length 3))
      (c2c (sierpinski-carpet c2 (- n 1)))
      (spacer (square c2 "white"))
      (row (lambda (a b c) (beside a b c)))
      (cr (row c2c c2c c2c))
      (mr (row c2c spacer c2c)))(above cr mr cr))))

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (sierpinski-triangle 400 0)
  (sierpinski-triangle 400 1)
  (sierpinski-triangle 400 2)
  (sierpinski-triangle 400 3)
  (sierpinski-triangle 400 4)

  (sierpinski-carpet 400 0)
  (sierpinski-carpet 400 1)
  (sierpinski-carpet 400 2)
  (sierpinski-carpet 400 3)
  (sierpinski-carpet 400 4)
)



