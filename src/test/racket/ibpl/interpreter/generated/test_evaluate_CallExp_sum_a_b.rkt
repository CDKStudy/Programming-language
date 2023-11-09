#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_8 = 
; 	let
; 		val sum_a_b = 
; 			fn(a) => 
; 			fn(b) => a + b
; 	in
; 		(sum_a_b(3))(5)
; 	end


(suite-enter "test_evaluate_CallExp_sum_a_b")

(assert-eval-equal? 
    8
    '(evaluate-in-empty-environment (LetExp "sum_a_b" (FunctionExp #f "a" (FunctionExp #f "b" (AddExp (IdentifierExp "a") (IdentifierExp "b")))) (CallExp (CallExp (IdentifierExp "sum_a_b") (IntExp 3)) (IntExp 5))))
   namespace
)


(suite-leave)