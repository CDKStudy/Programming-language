#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_425 = 
; 	let
; 		val x = 400
; 	in
; 		let
; 			val add_to_x = fn(y) =>
; 				x + y
; 			in
; 				add_to_x(25)
; 			end
; 	end


(suite-enter "test_evaluate_CallExp_add_to_x")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (LetExp "x" (IntExp 400) (LetExp "add_to_x" (FunctionExp #f "y" (AddExp (IdentifierExp "x") (IdentifierExp "y"))) (CallExp (IdentifierExp "add_to_x") (IntExp 25)))))
   namespace
)


(suite-leave)