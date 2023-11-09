#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val expected_12 = "(cons 1 2)"
; val eq_expected_12 = (1, 2) 
; 
; val expected_12_34 = "(cons (cons 1 2) (cons 3 4))"
; val eq_expected_12_34 = ((1, 2), (3, 4))


(suite-enter "test_evaluate_ConsExp_pair")


(assert-eval-equal? 
    (cons 1 2)
    '(evaluate-in-empty-environment (ConsExp (IntExp 1) (IntExp 2)))
   namespace
)


(assert-eval-equal? 
    (cons (cons 1 2) (cons 3 4))
    '(evaluate-in-empty-environment (ConsExp (ConsExp (IntExp 1) (IntExp 2)) (ConsExp (IntExp 3) (IntExp 4))))
   namespace
)


(suite-leave)