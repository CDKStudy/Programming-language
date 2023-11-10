#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_3 = 
; 	let
; 		val increment = fn(x) =>
; 			x + 1
; 	in
; 		increment(2)
; 	end


(suite-enter "test_evaluate_CallExp_increment")

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (LetExp "increment" (FunctionExp #f "x" (AddExp (IdentifierExp "x") (IntExp 1))) (CallExp (IdentifierExp "increment") (IntExp 2))))
   namespace
)


(suite-leave)