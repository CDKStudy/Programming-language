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
(assert-eval-equal? (ConsExp (IntExp 8) (ConsExp (IntExp 6) (ConsExp (IntExp 7) (ConsExp (IntExp 5) (ConsExp (IntExp 3) (ConsExp (IntExp 0) (ConsExp (IntExp 9) (NilExp)))))))) '(racket-integers->ib-IntExps '(8 6 7 5 3 0 9)) namespace)
(assert-eval-equal? (ConsExp (IntExp 7) (ConsExp (IntExp 7) (ConsExp (IntExp 7) (ConsExp (IntExp 93) (ConsExp (IntExp 11) (NilExp)))))) '(racket-integers->ib-IntExps '(7 7 7 93 11)) namespace)
(assert-eval-equal? (ConsExp (IntExp 0) (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (ConsExp (IntExp 6) (ConsExp (IntExp 7) (NilExp))))))))) '(racket-integers->ib-IntExps '(0 1 2 3 4 5 6 7)) namespace)
(assert-eval-equal? (ConsExp (IntExp 6) (ConsExp (IntExp 7) (ConsExp (IntExp 5) (ConsExp (IntExp 1) (ConsExp (IntExp 4) (ConsExp (IntExp 2) (ConsExp (IntExp 0) (ConsExp (IntExp 3) (NilExp))))))))) '(racket-integers->ib-IntExps '(6 7 5 1 4 2 0 3)) namespace)
(assert-eval-equal? (ConsExp (IntExp 10) (ConsExp (IntExp 20) (ConsExp (IntExp 30) (ConsExp (IntExp 40) (ConsExp (IntExp 50) (ConsExp (IntExp 60) (ConsExp (IntExp 70) (ConsExp (IntExp 80) (ConsExp (IntExp 90) (ConsExp (IntExp 100) (NilExp))))))))))) '(racket-integers->ib-IntExps '(10 20 30 40 50 60 70 80 90 100)) namespace)
(assert-eval-equal? (ConsExp (IntExp 100) (ConsExp (IntExp 80) (ConsExp (IntExp 10) (ConsExp (IntExp 40) (ConsExp (IntExp 20) (ConsExp (IntExp 30) (ConsExp (IntExp 50) (ConsExp (IntExp 90) (ConsExp (IntExp 70) (ConsExp (IntExp 60) (NilExp))))))))))) '(racket-integers->ib-IntExps '(100 80 10 40 20 30 50 90 70 60)) namespace)
(assert-eval-equal? (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (ConsExp (IntExp 6) (ConsExp (IntExp 7) (ConsExp (IntExp 8) (ConsExp (IntExp 9) (ConsExp (IntExp 10) (ConsExp (IntExp 11) (ConsExp (IntExp 12) (ConsExp (IntExp 13) (ConsExp (IntExp 14) (ConsExp (IntExp 15) (ConsExp (IntExp 16) (ConsExp (IntExp 17) (ConsExp (IntExp 18) (ConsExp (IntExp 19) (ConsExp (IntExp 20) (ConsExp (IntExp 21) (ConsExp (IntExp 22) (ConsExp (IntExp 23) (ConsExp (IntExp 24) (ConsExp (IntExp 25) (ConsExp (IntExp 26) (ConsExp (IntExp 27) (ConsExp (IntExp 28) (ConsExp (IntExp 29) (ConsExp (IntExp 30) (ConsExp (IntExp 31) (ConsExp (IntExp 32) (ConsExp (IntExp 33) (ConsExp (IntExp 34) (ConsExp (IntExp 35) (ConsExp (IntExp 36) (ConsExp (IntExp 37) (ConsExp (IntExp 38) (ConsExp (IntExp 39) (ConsExp (IntExp 40) (ConsExp (IntExp 41) (ConsExp (IntExp 42) (NilExp))))))))))))))))))))))))))))))))))))))))))) '(racket-integers->ib-IntExps '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42)) namespace)
(assert-eval-equal? (ConsExp (IntExp 37) (ConsExp (IntExp 36) (ConsExp (IntExp 22) (ConsExp (IntExp 4) (ConsExp (IntExp 32) (ConsExp (IntExp 16) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 8) (ConsExp (IntExp 6) (ConsExp (IntExp 17) (ConsExp (IntExp 7) (ConsExp (IntExp 12) (ConsExp (IntExp 14) (ConsExp (IntExp 35) (ConsExp (IntExp 26) (ConsExp (IntExp 5) (ConsExp (IntExp 10) (ConsExp (IntExp 42) (ConsExp (IntExp 13) (ConsExp (IntExp 9) (ConsExp (IntExp 23) (ConsExp (IntExp 41) (ConsExp (IntExp 28) (ConsExp (IntExp 39) (ConsExp (IntExp 29) (ConsExp (IntExp 15) (ConsExp (IntExp 20) (ConsExp (IntExp 24) (ConsExp (IntExp 30) (ConsExp (IntExp 34) (ConsExp (IntExp 21) (ConsExp (IntExp 19) (ConsExp (IntExp 1) (ConsExp (IntExp 11) (ConsExp (IntExp 38) (ConsExp (IntExp 25) (ConsExp (IntExp 33) (ConsExp (IntExp 18) (ConsExp (IntExp 40) (ConsExp (IntExp 27) (ConsExp (IntExp 31) (NilExp))))))))))))))))))))))))))))))))))))))))))) '(racket-integers->ib-IntExps '(37 36 22 4 32 16 2 3 8 6 17 7 12 14 35 26 5 10 42 13 9 23 41 28 39 29 15 20 24 30 34 21 19 1 11 38 25 33 18 40 27 31)) namespace)

(suite-leave)


(suite-enter "ibpl-IntExps->racket-integers")

(assert-eval-equal? '() '(ib-IntExps->racket-integers (NilExp)) namespace)
(assert-eval-equal? '(231) '(ib-IntExps->racket-integers (ConsExp (IntExp 231) (NilExp))) namespace)
(assert-eval-equal? '(231 425) '(ib-IntExps->racket-integers (ConsExp (IntExp 231) (ConsExp (IntExp 425) (NilExp)))) namespace)
(assert-eval-equal? '(2 4 6 8) '(ib-IntExps->racket-integers (ConsExp (IntExp 2) (ConsExp (IntExp 4) (ConsExp (IntExp 6) (ConsExp (IntExp 8) (NilExp)))))) namespace)
(assert-eval-equal? '(1 1 2 3 5 8 13 21 34) '(ib-IntExps->racket-integers (ConsExp (IntExp 1) (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 5) (ConsExp (IntExp 8) (ConsExp (IntExp 13) (ConsExp (IntExp 21) (ConsExp (IntExp 34) (NilExp))))))))))) namespace)
(assert-eval-equal? '(8 6 7 5 3 0 9) '(ib-IntExps->racket-integers (ConsExp (IntExp 8) (ConsExp (IntExp 6) (ConsExp (IntExp 7) (ConsExp (IntExp 5) (ConsExp (IntExp 3) (ConsExp (IntExp 0) (ConsExp (IntExp 9) (NilExp))))))))) namespace)
(assert-eval-equal? '(7 7 7 93 11) '(ib-IntExps->racket-integers (ConsExp (IntExp 7) (ConsExp (IntExp 7) (ConsExp (IntExp 7) (ConsExp (IntExp 93) (ConsExp (IntExp 11) (NilExp))))))) namespace)
(assert-eval-equal? '(0 1 2 3 4 5 6 7) '(ib-IntExps->racket-integers (ConsExp (IntExp 0) (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (ConsExp (IntExp 6) (ConsExp (IntExp 7) (NilExp)))))))))) namespace)
(assert-eval-equal? '(6 7 5 1 4 2 0 3) '(ib-IntExps->racket-integers (ConsExp (IntExp 6) (ConsExp (IntExp 7) (ConsExp (IntExp 5) (ConsExp (IntExp 1) (ConsExp (IntExp 4) (ConsExp (IntExp 2) (ConsExp (IntExp 0) (ConsExp (IntExp 3) (NilExp)))))))))) namespace)
(assert-eval-equal? '(10 20 30 40 50 60 70 80 90 100) '(ib-IntExps->racket-integers (ConsExp (IntExp 10) (ConsExp (IntExp 20) (ConsExp (IntExp 30) (ConsExp (IntExp 40) (ConsExp (IntExp 50) (ConsExp (IntExp 60) (ConsExp (IntExp 70) (ConsExp (IntExp 80) (ConsExp (IntExp 90) (ConsExp (IntExp 100) (NilExp)))))))))))) namespace)
(assert-eval-equal? '(100 80 10 40 20 30 50 90 70 60) '(ib-IntExps->racket-integers (ConsExp (IntExp 100) (ConsExp (IntExp 80) (ConsExp (IntExp 10) (ConsExp (IntExp 40) (ConsExp (IntExp 20) (ConsExp (IntExp 30) (ConsExp (IntExp 50) (ConsExp (IntExp 90) (ConsExp (IntExp 70) (ConsExp (IntExp 60) (NilExp)))))))))))) namespace)
(assert-eval-equal? '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42) '(ib-IntExps->racket-integers (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (ConsExp (IntExp 6) (ConsExp (IntExp 7) (ConsExp (IntExp 8) (ConsExp (IntExp 9) (ConsExp (IntExp 10) (ConsExp (IntExp 11) (ConsExp (IntExp 12) (ConsExp (IntExp 13) (ConsExp (IntExp 14) (ConsExp (IntExp 15) (ConsExp (IntExp 16) (ConsExp (IntExp 17) (ConsExp (IntExp 18) (ConsExp (IntExp 19) (ConsExp (IntExp 20) (ConsExp (IntExp 21) (ConsExp (IntExp 22) (ConsExp (IntExp 23) (ConsExp (IntExp 24) (ConsExp (IntExp 25) (ConsExp (IntExp 26) (ConsExp (IntExp 27) (ConsExp (IntExp 28) (ConsExp (IntExp 29) (ConsExp (IntExp 30) (ConsExp (IntExp 31) (ConsExp (IntExp 32) (ConsExp (IntExp 33) (ConsExp (IntExp 34) (ConsExp (IntExp 35) (ConsExp (IntExp 36) (ConsExp (IntExp 37) (ConsExp (IntExp 38) (ConsExp (IntExp 39) (ConsExp (IntExp 40) (ConsExp (IntExp 41) (ConsExp (IntExp 42) (NilExp)))))))))))))))))))))))))))))))))))))))))))) namespace)
(assert-eval-equal? '(37 36 22 4 32 16 2 3 8 6 17 7 12 14 35 26 5 10 42 13 9 23 41 28 39 29 15 20 24 30 34 21 19 1 11 38 25 33 18 40 27 31) '(ib-IntExps->racket-integers (ConsExp (IntExp 37) (ConsExp (IntExp 36) (ConsExp (IntExp 22) (ConsExp (IntExp 4) (ConsExp (IntExp 32) (ConsExp (IntExp 16) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 8) (ConsExp (IntExp 6) (ConsExp (IntExp 17) (ConsExp (IntExp 7) (ConsExp (IntExp 12) (ConsExp (IntExp 14) (ConsExp (IntExp 35) (ConsExp (IntExp 26) (ConsExp (IntExp 5) (ConsExp (IntExp 10) (ConsExp (IntExp 42) (ConsExp (IntExp 13) (ConsExp (IntExp 9) (ConsExp (IntExp 23) (ConsExp (IntExp 41) (ConsExp (IntExp 28) (ConsExp (IntExp 39) (ConsExp (IntExp 29) (ConsExp (IntExp 15) (ConsExp (IntExp 20) (ConsExp (IntExp 24) (ConsExp (IntExp 30) (ConsExp (IntExp 34) (ConsExp (IntExp 21) (ConsExp (IntExp 19) (ConsExp (IntExp 1) (ConsExp (IntExp 11) (ConsExp (IntExp 38) (ConsExp (IntExp 25) (ConsExp (IntExp 33) (ConsExp (IntExp 18) (ConsExp (IntExp 40) (ConsExp (IntExp 27) (ConsExp (IntExp 31) (NilExp)))))))))))))))))))))))))))))))))))))))))))) namespace)

(suite-leave)
(suite-leave)



