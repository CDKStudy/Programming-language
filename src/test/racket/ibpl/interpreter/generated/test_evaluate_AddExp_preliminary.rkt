#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_5 = 2 + 3
; val eq_9 = 2 + (3+4)
; val eq_10 = (1 + 2) + (3+4)
; val eq_21 = ((1 + 2) + (3+4)) + (5+6)
; val eq_28 = ((1 + 2) + (3+4)) + ((5+6) + 7)
; val eq_36 = ((1 + 2) + (3+4)) + ((5+6) + (7+8))


(suite-enter "test_evaluate_AddExp_preliminary")

(assert-eval-equal? 
    5
    '(evaluate-in-empty-environment (AddExp (IntExp 2) (IntExp 3)))
   namespace
)

(assert-eval-equal? 
    9
    '(evaluate-in-empty-environment (AddExp (IntExp 2) (AddExp (IntExp 3) (IntExp 4))))
   namespace
)

(assert-eval-equal? 
    10
    '(evaluate-in-empty-environment (AddExp (AddExp (IntExp 1) (IntExp 2)) (AddExp (IntExp 3) (IntExp 4))))
   namespace
)

(assert-eval-equal? 
    21
    '(evaluate-in-empty-environment (AddExp (AddExp (AddExp (IntExp 1) (IntExp 2)) (AddExp (IntExp 3) (IntExp 4))) (AddExp (IntExp 5) (IntExp 6))))
   namespace
)

(assert-eval-equal? 
    28
    '(evaluate-in-empty-environment (AddExp (AddExp (AddExp (IntExp 1) (IntExp 2)) (AddExp (IntExp 3) (IntExp 4))) (AddExp (AddExp (IntExp 5) (IntExp 6)) (IntExp 7))))
   namespace
)

(assert-eval-equal? 
    36
    '(evaluate-in-empty-environment (AddExp (AddExp (AddExp (IntExp 1) (IntExp 2)) (AddExp (IntExp 3) (IntExp 4))) (AddExp (AddExp (IntExp 5) (IntExp 6)) (AddExp (IntExp 7) (IntExp 8)))))
   namespace
)


(suite-leave)