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
; 		val identity = fn(x) =>
; 			x
; 	in
; 		identity(425)
; 	end


(suite-enter "test_evaluate_CallExp_identity")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (LetExp "identity" (FunctionExp #f "x" (IdentifierExp "x")) (CallExp (IdentifierExp "identity") (IntExp 425))))
   namespace
)


(suite-leave)