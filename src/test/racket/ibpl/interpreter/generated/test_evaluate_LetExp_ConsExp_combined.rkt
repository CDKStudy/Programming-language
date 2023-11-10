#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val expected_12 = "(cons 1 2)"
; val eq_expected_12 = 
; 	let
; 		val unused = 0
; 	in
; 		(1,2)
; 	end
; 
; val expected_34 = "(cons 3 4)"
; val eq_expected_34 = 
; 	let
; 		val a = 3
; 	in
; 		(a,4)
; 	end
; 
; val expected_56 = "(cons 5 6)"
; val eq_expected_56 = 
; 	let
; 		val b = 6
; 	in
; 		(5,b)
; 	end
; 
; val expected_78 = "(cons 7 8)"
; val eq_expected_78 = 
; 	let
; 		val a = 7
; 		val b = 8
; 	in
; 		(a,b)
; 	end
; 
; 
; val expected_9_10 = "(cons 9 10)"
; val eq_expected_9_10 = 
; 	(
; 		let
; 			val x = 9
; 		in
; 			x
; 		end
; 	, 
; 
; 		let
; 			val x = 10
; 		in
; 			x
; 		end
; 	)
; 
; val expected_11 = "(list 11)"
; val eq_expected_11 = 
; 	(
; 		let
; 			val x = 11
; 		in
; 			x
; 		end
; 	::
; 
; 		let
; 			val x = nil
; 		in
; 			x
; 		end
; 	)


(suite-enter "test_evaluate_LetExp_ConsExp_combined")


(assert-eval-equal? 
    (cons 1 2)
    '(evaluate-in-empty-environment (LetExp "unused" (IntExp 0) (ConsExp (IntExp 1) (IntExp 2))))
   namespace
)


(assert-eval-equal? 
    (cons 3 4)
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 3) (ConsExp (IdentifierExp "a") (IntExp 4))))
   namespace
)


(assert-eval-equal? 
    (cons 5 6)
    '(evaluate-in-empty-environment (LetExp "b" (IntExp 6) (ConsExp (IntExp 5) (IdentifierExp "b"))))
   namespace
)


(assert-eval-equal? 
    (cons 7 8)
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 7) (LetExp "b" (IntExp 8) (ConsExp (IdentifierExp "a") (IdentifierExp "b")))))
   namespace
)


(assert-eval-equal? 
    (cons 9 10)
    '(evaluate-in-empty-environment (ConsExp (LetExp "x" (IntExp 9) (IdentifierExp "x")) (LetExp "x" (IntExp 10) (IdentifierExp "x"))))
   namespace
)


(assert-eval-equal? 
    (list 11)
    '(evaluate-in-empty-environment (ConsExp (LetExp "x" (IntExp 11) (IdentifierExp "x")) (LetExp "x" (NilExp) (IdentifierExp "x"))))
   namespace
)


(suite-leave)