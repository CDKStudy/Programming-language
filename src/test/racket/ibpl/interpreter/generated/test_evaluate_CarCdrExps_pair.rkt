#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_425 = #1(425,231)
; val eq_231 = #2(425,231)
; 
; val eq_1 = #1(#1((1,2),(3,4)))
; val eq_2 = #2(#1((1,2),(3,4)))
; val eq_3 = #1(#2((1,2),(3,4)))
; val eq_4 = #2(#2((1,2),(3,4)))


(suite-enter "test_evaluate_CarCdrExps_pair")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (CarOfConsExp (ConsExp (IntExp 425) (IntExp 231))))
   namespace
)

(assert-eval-equal? 
    231
    '(evaluate-in-empty-environment (CdrOfConsExp (ConsExp (IntExp 425) (IntExp 231))))
   namespace
)

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (CarOfConsExp (CarOfConsExp (ConsExp (ConsExp (IntExp 1) (IntExp 2)) (ConsExp (IntExp 3) (IntExp 4))))))
   namespace
)

(assert-eval-equal? 
    2
    '(evaluate-in-empty-environment (CdrOfConsExp (CarOfConsExp (ConsExp (ConsExp (IntExp 1) (IntExp 2)) (ConsExp (IntExp 3) (IntExp 4))))))
   namespace
)

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (CarOfConsExp (CdrOfConsExp (ConsExp (ConsExp (IntExp 1) (IntExp 2)) (ConsExp (IntExp 3) (IntExp 4))))))
   namespace
)

(assert-eval-equal? 
    4
    '(evaluate-in-empty-environment (CdrOfConsExp (CdrOfConsExp (ConsExp (ConsExp (IntExp 1) (IntExp 2)) (ConsExp (IntExp 3) (IntExp 4))))))
   namespace
)


(suite-leave)