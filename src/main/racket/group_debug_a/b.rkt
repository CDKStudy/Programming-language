#lang racket
(require "../../test/racket/unit_testing/unit_testing.rkt")

(define (square x) (* x x))

(define sixteen square(4))


(assert-equal? 16 sixteen "sixteen")