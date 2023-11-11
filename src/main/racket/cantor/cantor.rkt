#lang racket
(require 2htdp/image)
(require 2htdp/universe)
(require "../spacer/spacer.rkt")
(provide (all-defined-out))

(define (brick w h)
  (overlay
   (rectangle w h "outline" "blue")
   (rectangle w h "solid" "red")
   )
  )

; Dekang Cao
(define (white w h)
(rectangle w h "solid" "white"))
(define (cantor-stool width height n)
(let* ((base (brick width (/ height 2)))
  (space (white (/ width 3) (/ height 2))))
  (if (= n 0)
  (brick width height)
    (let* ((neww (/ width 3))
      (newh (/ height 2))
      (left (cantor-stool neww newh (- n 1)))
      (middle space)
      (right (cantor-stool neww newh (- n 1)))
      (top (beside left (beside middle right))))(above base top)))))

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (cantor-stool 400 400 0)
  (cantor-stool 400 400 1)
  (cantor-stool 400 400 2)
  (cantor-stool 400 400 3)
  (cantor-stool 400 400 4)
)

