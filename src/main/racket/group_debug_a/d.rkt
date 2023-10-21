#lang racket
(require "../../test/racket/unit_testing/unit_testing.rkt")

(define xs [1, 2, 3, 4])


(assert-equal? (list 1 2 3 4) xs "xs")