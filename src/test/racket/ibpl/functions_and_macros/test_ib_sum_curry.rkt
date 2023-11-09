#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../../../main/racket/ibpl/functions_and_macros/functions.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "ib-sum-curry")

(assert-valid-ast? ib-sum-curry)
(assert-eval-equal? 8
                    '(evaluate-in-empty-environment
                      (CallExp (CallExp ib-sum-curry (IntExp 3)) (IntExp 5)))
                    namespace)

(suite-leave)
