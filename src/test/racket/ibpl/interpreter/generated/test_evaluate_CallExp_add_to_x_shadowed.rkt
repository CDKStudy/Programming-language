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
; 			val add_to_x_shadowed = fn(y) =>
; 				x + y
; 			in
; 				let 
; 					val x = 100
; 				in
; 					add_to_x_shadowed(25)
; 				end
; 			end
; 	end


(suite-enter "test_evaluate_CallExp_add_to_x_shadowed")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (LetExp "x" (IntExp 400) (LetExp "add_to_x_shadowed" (FunctionExp #f "y" (AddExp (IdentifierExp "x") (IdentifierExp "y"))) (LetExp "x" (IntExp 100) (CallExp (IdentifierExp "add_to_x_shadowed") (IntExp 25))))))
   namespace
)


(suite-leave)