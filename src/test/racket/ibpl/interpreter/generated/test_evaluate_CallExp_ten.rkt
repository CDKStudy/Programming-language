#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_10 = 
; 	let
; 		val ten = fn(unused) =>
; 			10
; 	in
; 		ten(0)
; 	end


(suite-enter "test_evaluate_CallExp_ten")

(assert-eval-equal? 
    10
    '(evaluate-in-empty-environment (LetExp "ten" (FunctionExp #f "unused" (IntExp 10)) (CallExp (IdentifierExp "ten") (IntExp 0))))
   namespace
)


(suite-leave)