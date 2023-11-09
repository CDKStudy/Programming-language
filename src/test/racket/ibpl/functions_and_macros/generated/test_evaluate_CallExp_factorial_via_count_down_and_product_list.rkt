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
; val eq_720 = 
; 	let
; 		val factorial = fn(n) =>
; 			let
; 				fun decrement(x) =
; 					x + ~1
; 
; 				val count_down = 
; 					fn(n) =>
; 						let
; 							fun helper(x) =
; 								if x > 0
; 								then x :: (helper(decrement(x)))
; 								else []
; 						in
; 							helper(n)
; 						end
; 
; 				val multiply = 
; 					fn(x) =>
; 					fn(y) =>
; 						let
; 							fun helper(y) =
; 								if y > 1
; 								then x + (helper(decrement(y)))
; 								else x
; 						in
; 							helper(y)
; 						end
; 
; 				fun product_list(xs) =
; 					if null(xs)
; 					then 1
; 					else (multiply(hd(xs)))(product_list(tl(xs)))
; 			in
; 				product_list(count_down(n))
; 			end
; 	in
; 		factorial(6)				  
; 	end


(suite-enter "test_evaluate_CallExp_factorial_via_count_down_and_product_list")

(assert-eval-equal? 
    720
    '(evaluate-in-empty-environment (LetExp "factorial" (FunctionExp #f "n" (IbLet* (list (binding "decrement" (FunctionExp "decrement" "x" (AddExp (IdentifierExp "x") (IntExp -1)))) (binding "count_down" (FunctionExp #f "n" (LetExp "helper" (FunctionExp "helper" "x" (IfGreaterExp (IdentifierExp "x") (IntExp 0) (ConsExp (IdentifierExp "x") (CallExp (IdentifierExp "helper") (CallExp (IdentifierExp "decrement") (IdentifierExp "x")))) (NilExp))) (CallExp (IdentifierExp "helper") (IdentifierExp "n"))))) (binding "multiply" (FunctionExp #f "x" (FunctionExp #f "y" (LetExp "helper" (FunctionExp "helper" "y" (IfGreaterExp (IdentifierExp "y") (IntExp 1) (AddExp (IdentifierExp "x") (CallExp (IdentifierExp "helper") (CallExp (IdentifierExp "decrement") (IdentifierExp "y")))) (IdentifierExp "x"))) (CallExp (IdentifierExp "helper") (IdentifierExp "y")))))) (binding "product_list" (FunctionExp "product_list" "xs" (IbIfNil (IdentifierExp "xs") (IntExp 1) (CallExp (CallExp (IdentifierExp "multiply") (CarOfConsExp (IdentifierExp "xs"))) (CallExp (IdentifierExp "product_list") (CdrOfConsExp (IdentifierExp "xs"))))))) ) (CallExp (IdentifierExp "product_list") (CallExp (IdentifierExp "count_down") (IdentifierExp "n"))))) (CallExp (IdentifierExp "factorial") (IntExp 6))))
   namespace
)


(suite-leave)