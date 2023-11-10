#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_evaluate_AddExp_malformed")

(assert-eval-exn 
 non-contract-exception?
 '(evaluate (AddExp (IntExp 425) (NilExp)) (list))
 namespace
 )

(assert-eval-exn 
 non-contract-exception?
 '(evaluate (AddExp (NilExp) (IntExp 425)) (list))
 namespace
 )

(suite-leave)

