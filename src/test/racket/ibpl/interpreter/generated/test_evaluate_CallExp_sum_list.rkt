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
; 		fun sum_list(xs) =
; 			if null(xs)
; 			then 0
; 			else (hd(xs)) + (sum_list(tl(xs)))
; 	in
; 		sum_list([400, 20, 5])
; 	end


(suite-enter "test_evaluate_CallExp_sum_list")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (LetExp "sum_list" (FunctionExp "sum_list" "xs" (IfGreaterExp (IsNilExp (IdentifierExp "xs")) (IntExp 0) (IntExp 0) (AddExp (CarOfConsExp (IdentifierExp "xs")) (CallExp (IdentifierExp "sum_list") (CdrOfConsExp (IdentifierExp "xs")))))) (CallExp (IdentifierExp "sum_list") (ConsExp (IntExp 400) (ConsExp (IntExp 20) (ConsExp (IntExp 5) (NilExp)))))))
   namespace
)

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (CallExp (FunctionExp "sum_list" "xs" (IfGreaterExp (IsNilExp (IdentifierExp "xs")) (IntExp 0) (IntExp 0) (AddExp (CarOfConsExp (IdentifierExp "xs")) (CallExp (IdentifierExp "sum_list") (CdrOfConsExp (IdentifierExp "xs")))))) (ConsExp (IntExp 400) (ConsExp (IntExp 20) (ConsExp (IntExp 5) (NilExp))))))
   namespace
)


(suite-leave)