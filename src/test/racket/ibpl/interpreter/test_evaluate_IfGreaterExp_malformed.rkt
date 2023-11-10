#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_evaluate_IfGreaterExp_malformed")

(assert-eval-exn 
 non-contract-exception?
 '(evaluate (IfGreaterExp (IntExp 1) (NilExp) (IntExp 425) (IntExp 231)) (list))
 namespace
 )

(assert-eval-exn 
 non-contract-exception?
 '(evaluate (IfGreaterExp (NilExp) (IntExp 2) (IntExp 425) (IntExp 231)) (list))
 namespace
 )

(suite-leave)

