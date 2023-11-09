#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../../../main/racket/ibpl/functions_and_macros/functions.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "ib-call-with-one")

(assert-valid-ast? ib-call-with-one)
(assert-eval-equal? 1
                    '(evaluate-in-empty-environment
                      (CallExp ib-call-with-one (FunctionExp #f "one" (IdentifierExp "one"))))
                    namespace)
(assert-eval-equal? 42
                    '(evaluate-in-empty-environment
                      (CallExp ib-call-with-one (FunctionExp #f "_" (IntExp 42))))
                    namespace)
(assert-eval-equal? 425
                    '(evaluate-in-empty-environment
                      (CallExp ib-call-with-one (FunctionExp #f "one" (AddExp (IdentifierExp "one") (IntExp 424)))))
                    namespace)

(suite-leave)
