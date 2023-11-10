#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_evaluate_IfGreaterExp_either_or")

; since 2 > 1 the poison pill (AddExp (NilExp) (NilExp)) should not be evaluated 
(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment 
        (IfGreaterExp 
            (IntExp 2) 
            (IntExp 1) 
            (IntExp 3) 
            (AddExp (NilExp) (NilExp))
        )
    )
   namespace
)

; since 1 is not > 2 the poison pill (AddExp (NilExp) (NilExp)) should not be evaluated 
(assert-eval-equal? 
    4
    '(evaluate-in-empty-environment 
        (IfGreaterExp 
            (IntExp 1) 
            (IntExp 2) 
            (AddExp (NilExp) (NilExp))
            (IntExp 4) 
        )
    )
   namespace
)


(suite-leave)