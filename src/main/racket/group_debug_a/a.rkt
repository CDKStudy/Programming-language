#lang racket
(require "../../test/racket/unit_testing/unit_testing.rkt")

(define five (2 + 3))


(assert-equal? 5 five "five")