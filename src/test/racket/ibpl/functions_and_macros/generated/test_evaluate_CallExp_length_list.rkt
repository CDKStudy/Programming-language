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
; val eq_4 = 
; 	let
; 		fun length_list(xs) =
; 			if null(xs)
; 			then 0
; 			else 1 + (length_list(tl(xs)))
; 	in
; 		length_list([2, 4, 6, 8])
; 	end


(suite-enter "test_evaluate_CallExp_length_list")

(assert-eval-equal? 
    4
    '(evaluate-in-empty-environment (LetExp "length_list" (FunctionExp "length_list" "xs" (IbIfNil (IdentifierExp "xs") (IntExp 0) (AddExp (IntExp 1) (CallExp (IdentifierExp "length_list") (CdrOfConsExp (IdentifierExp "xs")))))) (CallExp (IdentifierExp "length_list") (ConsExp (IntExp 2) (ConsExp (IntExp 4) (ConsExp (IntExp 6) (ConsExp (IntExp 8) (NilExp))))))))
   namespace
)

(assert-eval-equal? 
    4
    '(evaluate-in-empty-environment (CallExp (FunctionExp "length_list" "xs" (IbIfNil (IdentifierExp "xs") (IntExp 0) (AddExp (IntExp 1) (CallExp (IdentifierExp "length_list") (CdrOfConsExp (IdentifierExp "xs")))))) (ConsExp (IntExp 2) (ConsExp (IntExp 4) (ConsExp (IntExp 6) (ConsExp (IntExp 8) (NilExp)))))))
   namespace
)


(suite-leave)