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


(suite-enter "test_evaluate_NilExp_preliminary")

(assert-eval-equal? 
    null
    '(evaluate-in-empty-environment (NilExp))
   namespace
)


(suite-leave)