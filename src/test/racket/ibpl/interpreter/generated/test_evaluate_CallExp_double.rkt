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
; 		val double = fn(x) =>
; 			x + x
; 	in
; 		double(21)
; 	end


(suite-enter "test_evaluate_CallExp_double")

(assert-eval-equal? 
    42
    '(evaluate-in-empty-environment (LetExp "double" (FunctionExp #f "x" (AddExp (IdentifierExp "x") (IdentifierExp "x"))) (CallExp (IdentifierExp "double") (IntExp 21))))
   namespace
)


(suite-leave)