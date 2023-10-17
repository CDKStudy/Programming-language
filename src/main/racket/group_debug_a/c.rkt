#lang racket
(require "../../test/racket/unit_testing/unit_testing.rkt")

(define (hypotenuse a b) sqrt(a*a + b*b))


(define five (hypotenuse 3 4))

(assert-equal? 5 five "five")