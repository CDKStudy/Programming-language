#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../../../main/racket/ibpl/functions_and_macros/functions.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "ib-double")

(assert-valid-ast? ib-double)
(assert-eval-equal? 84
                    '(evaluate-in-empty-environment
                      (CallExp ib-double (IntExp 42)))
                    namespace)
(assert-eval-equal? 10
                    '(evaluate-in-empty-environment
                      (CallExp ib-double (AddExp (IntExp 2) (IntExp 3))))
                    namespace)
(assert-eval-equal? 850
                    '(evaluate-in-empty-environment
                      (CallExp ib-double (LetExp "x" (IntExp 400) (AddExp (IdentifierExp "x") (IntExp 25)))))
                    namespace)

(suite-leave)

