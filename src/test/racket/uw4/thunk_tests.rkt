#lang racket
(require "../../../main/racket/uw4/uw4.rkt")
(require "../unit_testing/unit_testing.rkt")
(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(define thunk-via-lambda (lambda () 4))
(define (thunk-via-parens) 66)
(define thunk-via-thunk (thunk 99))
(define not-a-thunk-value 231)
(define (not-a-thunk-function-arity x) (* x x))

(suite-enter "thunk_tests")

  (suite-enter "thunk?-and-dethunk-that")
    (assert-eval-true '(thunk? thunk-via-lambda) namespace)
    (assert-eval-equal? 4 '(dethunk-that thunk-via-lambda) namespace)

    (assert-eval-true '(thunk? thunk-via-parens) namespace)
    (assert-eval-equal? 66 '(dethunk-that thunk-via-parens) namespace)

    (assert-eval-true '(thunk? thunk-via-thunk) namespace)
    (assert-eval-equal? 99 (dethunk-that thunk-via-thunk) namespace)

    (assert-eval-false '(thunk? not-a-thunk-value) namespace)
    (assert-eval-exn 	exn:fail:contract? '(dethunk-that not-a-thunk-value) namespace)

    (assert-eval-false '(thunk? not-a-thunk-function-arity) namespace)
    (assert-eval-exn 	exn:fail:contract? '(dethunk-that not-a-thunk-function-arity) namespace)

  (suite-leave)

(define thunk-via-thunk-that (thunk-that 425))
(define thunk-that-poison (thunk-that (error (/ 1 0))))

  (suite-enter "thunk-that")
    (assert-eval-true (procedure? thunk-via-thunk-that) namespace)
    (assert-eval-equal? 0 (procedure-arity thunk-via-thunk-that) namespace)
    (assert-eval-true (thunk? thunk-via-thunk-that) namespace)
    (assert-eval-equal? 425 (thunk-via-thunk-that) namespace)
    (assert-eval-equal? 425 (dethunk-that thunk-via-thunk-that) namespace)

    (assert-eval-true (procedure? thunk-that-poison) namespace)
    (assert-eval-equal? 0 (procedure-arity thunk-that-poison) namespace)
    (assert-eval-true (thunk? thunk-that-poison) namespace)

    (assert-eval-exn exn:fail:contract:divide-by-zero? '(dethunk-that thunk-that-poison) namespace)
  (suite-leave)

(suite-leave)