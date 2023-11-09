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
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 40) (LetExp "b" (IntExp 2) (AddExp (IdentifierExp "a") (IdentifierExp "b")))))
   namespace
)

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 400) (LetExp "b" (IntExp 20) (LetExp "c" (IntExp 5) (AddExp (AddExp (IdentifierExp "a") (IdentifierExp "b")) (IdentifierExp "c"))))))
   namespace
)

(assert-eval-equal? 
    1234
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 1000) (LetExp "b" (IntExp 200) (LetExp "c" (IntExp 30) (LetExp "d" (IntExp 4) (AddExp (AddExp (IdentifierExp "a") (IdentifierExp "b")) (AddExp (IdentifierExp "c") (IdentifierExp "d"))))))))
   namespace
)

(assert-eval-equal? 
    2468
    '(evaluate-in-empty-environment (AddExp (LetExp "a" (IntExp 2000) (LetExp "b" (IntExp 400) (AddExp (IdentifierExp "a") (IdentifierExp "b")))) (LetExp "a" (IntExp 60) (LetExp "b" (IntExp 8) (AddExp (IdentifierExp "a") (IdentifierExp "b"))))))
   namespace
)


(suite-leave)