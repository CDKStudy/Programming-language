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
; val expected_54321 = "(list 5 4 3 2 1)"
; val eq_expected_54321 = 
; 	let
; 		fun decrement(x) =
; 			x + ~1
; 
; 		fun count_down(n) =
; 			if n > 0
; 			then n :: (count_down(decrement(n)))
; 			else []
; 	in
; 		count_down(5)
; 	end


(suite-enter "test_evaluate_CallExp_count_down")


(assert-eval-equal? 
    (list 5 4 3 2 1)
    '(evaluate-in-empty-environment (IbLet* (list (binding "decrement" (FunctionExp "decrement" "x" (AddExp (IdentifierExp "x") (IntExp -1)))) (binding "count_down" (FunctionExp "count_down" "n" (IfGreaterExp (IdentifierExp "n") (IntExp 0) (ConsExp (IdentifierExp "n") (CallExp (IdentifierExp "count_down") (CallExp (IdentifierExp "decrement") (IdentifierExp "n")))) (NilExp)))) ) (CallExp (IdentifierExp "count_down") (IntExp 5))))
   namespace
)


(suite-leave)