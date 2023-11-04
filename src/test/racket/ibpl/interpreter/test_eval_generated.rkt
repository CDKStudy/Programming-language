#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")
(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))
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
    2
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 3) (IntExp 2)))
   namespace
)

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 3) (IdentifierExp "a")))
   namespace
)

(assert-eval-equal? 
    6
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 5) (AddExp (IdentifierExp "a") (IntExp 1))))
   namespace
)

(assert-eval-equal? 
    12
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 10) (AddExp (IntExp 2) (IdentifierExp "a"))))
   namespace
)

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

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (IsNilExp (LetExp "unused" (IntExp 425) (NilExp))))
   namespace
)

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (LetExp "x" (NilExp) (IsNilExp (IdentifierExp "x"))))
   namespace
)

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (LetExp "f" (FunctionExp "f" "unused" (NilExp)) (IsNilExp (CallExp (IdentifierExp "f") (IntExp 231)))))
   namespace
)

(assert-eval-equal? 
    10
    '(evaluate-in-empty-environment (CarOfConsExp (ConsExp (IntExp 10) (NilExp))))
   namespace
)

(assert-eval-equal? 
    42
    '(evaluate-in-empty-environment (LetExp "xs" (ConsExp (IntExp 42) (NilExp)) (CarOfConsExp (IdentifierExp "xs"))))
   namespace
)

(assert-eval-equal? 
    20
    '(evaluate-in-empty-environment (LetExp "double" (FunctionExp "double" "y" (AddExp (IdentifierExp "y") (IdentifierExp "y"))) (CallExp (IdentifierExp "double") (IntExp 10))))
   namespace
)

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (LetExp "add" (FunctionExp "add" "a" (FunctionExp #f "b" (AddExp (IdentifierExp "a") (IdentifierExp "b")))) (CallExp (CallExp (IdentifierExp "add") (IntExp 1)) (IntExp 2))))
   namespace
)


(define expected_12345 (list 1 2 3 4 5))
(assert-eval-equal? 
    expected_12345
    '(evaluate-in-empty-environment (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp)))))))
   namespace
)

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

