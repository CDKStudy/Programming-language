#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_evaluate_FunctionExp")

(define environment (list (entry "y" 1)))
(define function_exp (FunctionExp #f "y" (AddExp (IdentifierExp "x") (IdentifierExp "y"))))

(define actual (evaluate function_exp environment))

(assert-eval-true '(closure? actual) namespace)
(assert-eval-equal? environment '(closure-env actual) namespace)
(assert-eval-equal? function_exp '(closure-function actual) namespace)

(suite-leave)