#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_42 = 
; 	let
; 		val multiply = 
; 			fn(x) =>
; 			fn(y) =>
; 				let 
; 					fun decrement(y) =
; 						y + ~1
; 				in
; 					let
; 						fun helper(y) =
; 							if y > 1
; 							then x + (helper(decrement(y)))
; 							else x
; 					in
; 						helper(y)
; 					end
; 				end
; 	in
; 		(multiply(6))(7)
; 	end


(suite-enter "test_evaluate_CallExp_multiply")

(assert-eval-equal? 
    42
    '(evaluate-in-empty-environment (LetExp "multiply" (FunctionExp #f "x" (FunctionExp #f "y" (LetExp "decrement" (FunctionExp "decrement" "y" (AddExp (IdentifierExp "y") (IntExp -1))) (LetExp "helper" (FunctionExp "helper" "y" (IfGreaterExp (IdentifierExp "y") (IntExp 1) (AddExp (IdentifierExp "x") (CallExp (IdentifierExp "helper") (CallExp (IdentifierExp "decrement") (IdentifierExp "y")))) (IdentifierExp "x"))) (CallExp (IdentifierExp "helper") (IdentifierExp "y")))))) (CallExp (CallExp (IdentifierExp "multiply") (IntExp 6)) (IntExp 7))))
   namespace
)


(suite-leave)