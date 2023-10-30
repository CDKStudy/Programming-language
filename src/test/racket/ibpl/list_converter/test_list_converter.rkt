#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/list_converter/list_converter.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "warmup_tests")
(suite-enter "racket-integers->ibpl-IntExps")

(assert-eval-equal? (NilExp) '(racket-integers->ib-IntExps '()) namespace)
(assert-eval-equal? (ConsExp (IntExp 231) (NilExp)) '(racket-integers->ib-IntExps '(231)) namespace)
(assert-eval-equal? (ConsExp (IntExp 231) (ConsExp (IntExp 425) (NilExp))) '(racket-integers->ib-IntExps '(231 425)) namespace)
(assert-eval-equal? (ConsExp (IntExp 2) (ConsExp (IntExp 4) (ConsExp (IntExp 6) (ConsExp (IntExp 8) (NilExp))))) '(racket-integers->ib-IntExps '(2 4 6 8)) namespace)
(assert-eval-equal? (ConsExp (IntExp 1) (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 5) (ConsExp (IntExp 8) (ConsExp (IntExp 13) (ConsExp (IntExp 21) (ConsExp (IntExp 34) (NilExp)))))))))) '(racket-integers->ib-IntExps '(1 1 2 3 5 8 13 21 34)) namespace)

(suite-leave)


(suite-enter "ibpl-IntExps->racket-integers")

(assert-eval-equal? '() '(ib-IntExps->racket-integers (NilExp)) namespace)
(assert-eval-equal? '(231) '(ib-IntExps->racket-integers (ConsExp (IntExp 231) (NilExp))) namespace)
(assert-eval-equal? '(231 425) '(ib-IntExps->racket-integers (ConsExp (IntExp 231) (ConsExp (IntExp 425) (NilExp)))) namespace)
(assert-eval-equal? '(2 4 6 8) '(ib-IntExps->racket-integers (ConsExp (IntExp 2) (ConsExp (IntExp 4) (ConsExp (IntExp 6) (ConsExp (IntExp 8) (NilExp)))))) namespace)
(assert-eval-equal? '(1 1 2 3 5 8 13 21 34) '(ib-IntExps->racket-integers (ConsExp (IntExp 1) (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 5) (ConsExp (IntExp 8) (ConsExp (IntExp 13) (ConsExp (IntExp 21) (ConsExp (IntExp 34) (NilExp))))))))))) namespace)

(suite-leave)
(suite-leave)
