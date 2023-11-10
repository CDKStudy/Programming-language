#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../../../main/racket/ibpl/functions_and_macros/functions.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "ib-map")

(assert-valid-ast? ib-map)
(assert-eval-equal? null '(evaluate-in-empty-environment
                           (CallExp
                            (CallExp ib-map ib-double)
                            (NilExp))) namespace)
(assert-eval-equal? (list 850) '(evaluate-in-empty-environment
                                 (CallExp
                                  (CallExp ib-map ib-double)
                                  (ConsExp (IntExp 425) (NilExp)))) namespace)
(assert-eval-equal? (list 2 4 6 8) '(evaluate-in-empty-environment
                                     (CallExp
                                      (CallExp ib-map ib-double)
                                      (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (NilExp))))))) namespace)

(suite-leave)
