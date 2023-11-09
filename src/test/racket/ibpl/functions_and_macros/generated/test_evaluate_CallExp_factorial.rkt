#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../../../../main/racket/ibpl/functions_and_macros/macros.rkt")
(require "../../../../../main/racket/ibpl/functions_and_macros/functions.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_120 = 
; 	let 
; 		fun decrement(y) =
; 			y + ~1
; 
; 		fun multiply(x) =
; 			fn(y) =>
; 				let
; 					fun helper(y) =
; 						if y > 1
; 						then x + (helper(decrement(y)))
; 						else x
; 				in
; 					helper(y)
; 				end
; 
; 		fun factorial(n) =
; 			if n>1
; 			then (multiply(n))(factorial(decrement(n)))
; 			else 1
; 	in
; 		factorial(5)
; 	end


(suite-enter "test_evaluate_CallExp_factorial")

(assert-eval-equal? 
    120
    '(evaluate-in-empty-environment (IbLet* (list (binding "decrement" (FunctionExp "decrement" "y" (AddExp (IdentifierExp "y") (IntExp -1)))) (binding "multiply" (FunctionExp "multiply" "x" (FunctionExp #f "y" (LetExp "helper" (FunctionExp "helper" "y" (IfGreaterExp (IdentifierExp "y") (IntExp 1) (AddExp (IdentifierExp "x") (CallExp (IdentifierExp "helper") (CallExp (IdentifierExp "decrement") (IdentifierExp "y")))) (IdentifierExp "x"))) (CallExp (IdentifierExp "helper") (IdentifierExp "y")))))) (binding "factorial" (FunctionExp "factorial" "n" (IfGreaterExp (IdentifierExp "n") (IntExp 1) (CallExp (CallExp (IdentifierExp "multiply") (IdentifierExp "n")) (CallExp (IdentifierExp "factorial") (CallExp (IdentifierExp "decrement") (IdentifierExp "n")))) (IntExp 1)))) ) (CallExp (IdentifierExp "factorial") (IntExp 5))))
   namespace
)


(suite-leave)