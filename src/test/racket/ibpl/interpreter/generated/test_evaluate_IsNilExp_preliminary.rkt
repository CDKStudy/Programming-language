#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_null = nil
; 
; val eq_1 = null(nil)
; val eq_0 = null(1)


(suite-enter "test_evaluate_IsNilExp_preliminary")

(assert-eval-equal? 
    null
    '(evaluate-in-empty-environment (NilExp))
   namespace
)

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (IsNilExp (NilExp)))
   namespace
)

(assert-eval-equal? 
    0
    '(evaluate-in-empty-environment (IsNilExp (IntExp 1)))
   namespace
)


(suite-leave)