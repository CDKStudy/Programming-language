#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_6 = 
;   let
;     val a = 5
;   in 
;     a + 1
;   end
; 
; val eq_12 = 
;   let
;     val a = 10
;   in 
;     2 + a
;   end
; 
; 
; val eq_42 = 
;   40 + 
;     let
;       val unused = 10
;     in 
;       2
;     end
; 
; val eq_425 = 
;   400 + 
;     let
;       val twenty_five = 25
;     in 
;       twenty_five
;     end


(suite-enter "test_evaluate_LetExp_AddExp_combined")

(assert-eval-equal? 
    6
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 5) (AddExp (IdentifierExp "a") (IntExp 1))))
   namespace
)

(assert-eval-equal? 
    12
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 10) (AddExp (IntExp 2) (IdentifierExp "a"))))
   namespace
)

(assert-eval-equal? 
    42
    '(evaluate-in-empty-environment (AddExp (IntExp 40) (LetExp "unused" (IntExp 10) (IntExp 2))))
   namespace
)

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (AddExp (IntExp 400) (LetExp "twenty_five" (IntExp 25) (IdentifierExp "twenty_five"))))
   namespace
)


(suite-leave)