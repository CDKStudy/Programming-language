#lang racket

(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_value?")

(assert-eval-true '(value? 425) namespace)

(assert-eval-true '(value? null) namespace)

(assert-eval-false '(value? "abc") namespace)
(assert-eval-false '(value? (IntExp 425)) namespace)
(assert-eval-false '(value? (NilExp)) namespace)
(assert-eval-false '(value? (ConsExp (IntExp 1) (IntExp 2))) namespace)
(assert-eval-false '(value? (FunctionExp #f "x" (IntExp 42))) namespace)

(assert-eval-true '(value? (cons null null)) namespace)
(assert-eval-true '(value? (cons 1 null)) namespace)
(assert-eval-true '(value? (cons 1 null)) namespace)
(assert-eval-true '(value? (cons 1 2)) namespace)
(assert-eval-false '(value? (cons "a" "b")) namespace)

(assert-eval-true '(value? (cons (cons 1 2) 3)) namespace)
(assert-eval-true '(value? (cons (cons 1 2) (cons 3 4))) namespace)

(assert-eval-false '(value? (cons (cons (cons "a" 1) 2) (cons 3 4))) namespace)
(assert-eval-false '(value? (cons (cons 1 (cons "a" 2)) (cons 3 4))) namespace)
(assert-eval-false '(value? (cons (cons 1 (cons 2 "a")) (cons 3 4))) namespace)
(assert-eval-false '(value? (cons (cons 1 2) (cons (cons "a" 3) 4))) namespace)
(assert-eval-false '(value? (cons (cons 1 2) (cons (cons 3 "a") 4))) namespace)
(assert-eval-false '(value? (cons (cons 1 2) (cons 3 (cons "a" 4)))) namespace)
(assert-eval-false '(value? (cons (cons 1 2) (cons 3 (cons 4 "a")))) namespace)


(assert-eval-true '(value? (closure (list) (FunctionExp #f "x" (IntExp 42)))) namespace)

; use exact-integer?
(assert-eval-false '(value? 425.0) namespace)

(suite-leave)