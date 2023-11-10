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
; val eq_3000 = 
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
; 		fun product_list(xs) =
; 			if null(xs)
; 			then 1
; 			else (multiply(hd(xs)))(product_list(tl(xs)))
; 	in
; 		product_list([3, 5, 10, 20])
; 	end


(suite-enter "test_evaluate_CallExp_product_list")

(assert-eval-equal? 
    3000
    '(evaluate-in-empty-environment (IbLet* (list (binding "multiply" (FunctionExp #f "x" (FunctionExp #f "y" (LetExp "decrement" (FunctionExp "decrement" "y" (AddExp (IdentifierExp "y") (IntExp -1))) (LetExp "helper" (FunctionExp "helper" "y" (IfGreaterExp (IdentifierExp "y") (IntExp 1) (AddExp (IdentifierExp "x") (CallExp (IdentifierExp "helper") (CallExp (IdentifierExp "decrement") (IdentifierExp "y")))) (IdentifierExp "x"))) (CallExp (IdentifierExp "helper") (IdentifierExp "y"))))))) (binding "product_list" (FunctionExp "product_list" "xs" (IbIfNil (IdentifierExp "xs") (IntExp 1) (CallExp (CallExp (IdentifierExp "multiply") (CarOfConsExp (IdentifierExp "xs"))) (CallExp (IdentifierExp "product_list") (CdrOfConsExp (IdentifierExp "xs"))))))) ) (CallExp (IdentifierExp "product_list") (ConsExp (IntExp 3) (ConsExp (IntExp 5) (ConsExp (IntExp 10) (ConsExp (IntExp 20) (NilExp))))))))
   namespace
)


(suite-leave)