#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_425 = 425
; val eq_231 = 231


(suite-enter "test_evaluate_IntExp")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (IntExp 425))
   namespace
)

(assert-eval-equal? 
    231
    '(evaluate-in-empty-environment (IntExp 231))
   namespace
)


(suite-leave)