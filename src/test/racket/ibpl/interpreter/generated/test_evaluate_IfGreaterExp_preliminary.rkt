#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_3 =
;     if 2 > 1
;     then 3
;     else 4
; 
; val eq_4 =
;     if 1 > 2
;     then 3
;     else 4


(suite-enter "test_evaluate_IfGreaterExp_preliminary")

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (IfGreaterExp (IntExp 2) (IntExp 1) (IntExp 3) (IntExp 4)))
   namespace
)

(assert-eval-equal? 
    4
    '(evaluate-in-empty-environment (IfGreaterExp (IntExp 1) (IntExp 2) (IntExp 3) (IntExp 4)))
   namespace
)


(suite-leave)