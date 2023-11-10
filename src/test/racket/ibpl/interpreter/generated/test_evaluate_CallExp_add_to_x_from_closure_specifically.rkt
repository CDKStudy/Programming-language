#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_evaluate_CallExp_add_to_x_from_closure_specifically")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (LetExp "x" (IntExp 400) (LetExp "add_to_x_from_closure_specifically" (FunctionExp "add_to_x_from_closure_specifically" "y" (AddExp (IdentifierExp "x") (IdentifierExp "y"))) (LetExp "x" (IntExp 100) (CallExp (IdentifierExp "add_to_x_from_closure_specifically") (IntExp 25))))))
   namespace
)


(suite-leave)