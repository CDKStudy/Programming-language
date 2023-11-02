#lang racket

(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_expand-environment")

(assert-eval-equal? (list (entry "a" 1)) '(expand-environment "a" 1 null) namespace)
(assert-eval-equal? (list (entry "b" 2) (entry "a" 1)) '(expand-environment "b" 2 (list (entry "a" 1))) namespace)
(assert-eval-equal? (list  (entry "a" 3) (entry "b" 2) (entry "a" 1)) '(expand-environment "a" 3 (list (entry "b" 2) (entry "a" 1))) namespace)

; env argument errors
(assert-eval-exn exn:fail:contract? '(expand-environment "a" 1 (ConsExp (IntExp 42) (NilExp))) namespace)
(assert-eval-exn exn:fail:contract? '(expand-environment "a" 1 "NotAList") namespace)

; name argument errors
(assert-eval-exn exn:fail:contract? '(expand-environment (IdentifierExp "a") 1 null) namespace)
(assert-eval-exn exn:fail:contract? '(expand-environment 2 1 null) namespace)

; value argument errors
(assert-eval-exn exn:fail:contract? '(expand-environment "a" (IntExp 1) null) namespace)
(assert-eval-exn exn:fail:contract? '(expand-environment "a" "b" null) namespace)

(suite-leave)
