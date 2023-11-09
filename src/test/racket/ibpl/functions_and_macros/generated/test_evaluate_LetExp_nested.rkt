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
; val eq_42 = 
; 	let
; 		val a = 40
; 		val b = 2
; 	in 
; 		a + b
; 	end
; 
; val eq_425 = 
; 	let
; 		val a = 400
; 		val b = 20
; 		val c = 5
; 	in 
; 		(a + b) + c
; 	end
; 
; val eq_1234 = 
; 	let
; 		val a = 1000
; 		val b = 200
; 		val c = 30
; 		val d = 4
; 	in 
; 		(a + b) + (c + d)
; 	end
; 
; val eq_2468 = 
; 	let
; 		val a = 2000
; 		val b = 400
; 	in 
; 		(a + b)
; 	end
; 
; 	+
; 	
; 	let
; 		val a = 60
; 		val b = 8
; 	in 
; 		(a + b)
; 	end


(suite-enter "test_evaluate_LetExp_nested")

(assert-eval-equal? 
    42
    '(evaluate-in-empty-environment (IbLet* (list (binding "a" (IntExp 40)) (binding "b" (IntExp 2)) ) (AddExp (IdentifierExp "a") (IdentifierExp "b"))))
   namespace
)

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (IbLet* (list (binding "a" (IntExp 400)) (binding "b" (IntExp 20)) (binding "c" (IntExp 5)) ) (AddExp (AddExp (IdentifierExp "a") (IdentifierExp "b")) (IdentifierExp "c"))))
   namespace
)

(assert-eval-equal? 
    1234
    '(evaluate-in-empty-environment (IbLet* (list (binding "a" (IntExp 1000)) (binding "b" (IntExp 200)) (binding "c" (IntExp 30)) (binding "d" (IntExp 4)) ) (AddExp (AddExp (IdentifierExp "a") (IdentifierExp "b")) (AddExp (IdentifierExp "c") (IdentifierExp "d")))))
   namespace
)

(assert-eval-equal? 
    2468
    '(evaluate-in-empty-environment (AddExp (IbLet* (list (binding "a" (IntExp 2000)) (binding "b" (IntExp 400)) ) (AddExp (IdentifierExp "a") (IdentifierExp "b"))) (IbLet* (list (binding "a" (IntExp 60)) (binding "b" (IntExp 8)) ) (AddExp (IdentifierExp "a") (IdentifierExp "b")))))
   namespace
)


(suite-leave)