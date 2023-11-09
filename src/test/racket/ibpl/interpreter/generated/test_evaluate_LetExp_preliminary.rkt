#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_2 = 
;   let
;     val unused = 3
;   in 
;     2
;   end
; 
; val eq_3 = 
;   let
;     val a = 3
;   in 
;     a
;   end


(suite-enter "test_evaluate_LetExp_preliminary")

(assert-eval-equal? 
    2
    '(evaluate-in-empty-environment (LetExp "unused" (IntExp 3) (IntExp 2)))
   namespace
)

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (LetExp "a" (IntExp 3) (IdentifierExp "a")))
   namespace
)


(suite-leave)