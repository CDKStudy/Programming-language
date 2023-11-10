#lang racket
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../util/utils.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "test_evaluate_IdentifierExp")

(assert-eval-equal? 
 1
 '(evaluate (IdentifierExp "x") (list (entry "x" 1)))
 namespace
 )

(assert-eval-equal? 
 1
 '(evaluate (IdentifierExp "x") (list (entry "x" 1) (entry "y" 2)))
 namespace
 )

(assert-eval-equal? 
 2
 '(evaluate (IdentifierExp "y") (list (entry "x" 1) (entry "y" 2)))
 namespace
 )

(assert-eval-equal? 
 1
 '(evaluate (IdentifierExp "x") (list (entry "x" 1) (entry "x" 2)))
 namespace
 )

(assert-eval-equal? 
 1
 '(evaluate (IdentifierExp "a") (list (entry "a" 1) (entry "b" 2) (entry "c" 3) (entry "d" 4) (entry "e" 5)))
 namespace
 )

(assert-eval-equal? 
 2
 '(evaluate (IdentifierExp "b") (list (entry "a" 1) (entry "b" 2) (entry "c" 3) (entry "d" 4) (entry "e" 5)))
 namespace
 )

(assert-eval-equal? 
 3
 '(evaluate (IdentifierExp "c") (list (entry "a" 1) (entry "b" 2) (entry "c" 3) (entry "d" 4) (entry "e" 5)))
 namespace
 )

(assert-eval-equal? 
 4
 '(evaluate (IdentifierExp "d") (list (entry "a" 1) (entry "b" 2) (entry "c" 3) (entry "d" 4) (entry "e" 5)))
 namespace
 )

(assert-eval-equal? 
 5
 '(evaluate (IdentifierExp "e") (list (entry "a" 1) (entry "b" 2) (entry "c" 3) (entry "d" 4) (entry "e" 5)))
 namespace
 )

(assert-eval-exn 
 exn:fail?
 '(evaluate (IdentifierExp "not_in_environment") (list))
 namespace
 )

(assert-eval-exn 
 exn:fail?
 '(evaluate (IdentifierExp "not_in_environment") (list (entry "a" 1) (entry "b" 2) (entry "c" 3) (entry "d" 4) (entry "e" 5)))
 namespace
 )

(suite-leave)

