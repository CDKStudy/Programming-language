#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_425 = hd(425::nil)
; val eq_null = tl(425::nil)


(suite-enter "test_evaluate_CarCdrExps_preliminary")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (CarOfConsExp (ConsExp (IntExp 425) (NilExp))))
   namespace
)

(assert-eval-equal? 
    null
    '(evaluate-in-empty-environment (CdrOfConsExp (ConsExp (IntExp 425) (NilExp))))
   namespace
)


(suite-leave)