#lang racket
(require "../../../main/racket/uw4/uw4.rkt")
(require "../unit_testing/unit_testing.rkt")
(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(define not-a-thunk-value 231)
(define (not-a-thunk-function-arity x) (* x x))

(define powers-of-two-stream
  (letrec ([f (lambda (x)
                (cons-with-thunk-check-on-next-stream x (thunk-that (f (* x 2)))))])
    (thunk-that (f 1))))

(define (pair-to-values pair)
  (if (pair? pair)
      (values (car pair) (cdr pair))
      (raise-argument-error 'pair "pair?" pair)))

(define-values (should-be-1 next-stream) (pair-to-values (destream powers-of-two-stream)))
(define-values (should-be-2 next-next-stream) (pair-to-values (destream next-stream)))
(define-values (should-be-4 next-next-next-stream) (pair-to-values (destream next-next-stream)))
(define-values (should-be-8 next-next-next-next-stream) (pair-to-values(destream next-next-next-stream)))

(suite-enter "stream_tests")

   (assert-equal? 1 should-be-1 "should-be-1")
   (assert-equal? 2 should-be-2 "should-be-2")
   (assert-equal? 4 should-be-4 "should-be-4")
   (assert-equal? 8 should-be-8 "should-be-8")

   (assert-eval-exn exn:fail:contract? '(destream (dethunk-that powers-of-two-stream)) namespace)

   (assert-eval-exn exn:fail:contract? '(destream (thunk-that (cons "ignored" not-a-thunk-value))) namespace)
   (assert-eval-exn exn:fail:contract? '(destream (thunk-that (cons "ignored" not-a-thunk-function-arity))) namespace)

   (assert-eval-exn exn:fail:contract? '(cons-with-thunk-check-on-next-stream "ignored" not-a-thunk-value) namespace)
   (assert-eval-exn exn:fail:contract? '(cons-with-thunk-check-on-next-stream "ignored" not-a-thunk-function-arity) namespace)

(suite-leave)
