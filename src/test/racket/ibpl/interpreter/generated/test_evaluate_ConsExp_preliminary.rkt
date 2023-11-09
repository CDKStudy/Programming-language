#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val expected_1 = "(list 1)"
; val eq_expected_1 = [1] 
; 
; val expected_12 = "(list 1 2)"
; val eq_expected_12 = [1,2] 
; 
; val expected_123 = "(list 1 2 3)"
; val eq_expected_123 = [1,2,3] 
; 
; val expected_1234 = "(list 1 2 3 4)"
; val eq_expected_1234 = [1,2,3,4] 
; 
; val expected_12345 = "(list 1 2 3 4 5)"
; val eq_expected_12345 = [1,2,3,4,5] 


(suite-enter "test_evaluate_ConsExp_preliminary")


(assert-eval-equal? 
    (list 1)
    '(evaluate-in-empty-environment (ConsExp (IntExp 1) (NilExp)))
   namespace
)


(assert-eval-equal? 
    (list 1 2)
    '(evaluate-in-empty-environment (ConsExp (IntExp 1) (ConsExp (IntExp 2) (NilExp))))
   namespace
)


(assert-eval-equal? 
    (list 1 2 3)
    '(evaluate-in-empty-environment (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (NilExp)))))
   namespace
)


(assert-eval-equal? 
    (list 1 2 3 4)
    '(evaluate-in-empty-environment (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (NilExp))))))
   namespace
)


(assert-eval-equal? 
    (list 1 2 3 4 5)
    '(evaluate-in-empty-environment (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp)))))))
   namespace
)


(suite-leave)