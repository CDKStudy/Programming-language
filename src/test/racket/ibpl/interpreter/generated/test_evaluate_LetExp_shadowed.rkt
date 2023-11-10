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
;     val x = 1
;   in 
;     let
;       val x = 2
;     in 
;       x
;     end
;   end
; 
; val eq_3 = 
;   let
;     val x = 1
;   in 
;     let
;       val y = 2
;     in 
;       let
;         val x = 3
;       in 
;         x
;       end
;     end
;   end
; 
; val eq_5 = 
;   let
;     val x = 1
;   in 
;     let
;       val y = 2
;     in 
;       let
;         val x = 3
;       in 
;         x + y
;       end
;     end
;   end


(suite-enter "test_evaluate_LetExp_shadowed")

(assert-eval-equal? 
    2
    '(evaluate-in-empty-environment (LetExp "x" (IntExp 1) (LetExp "x" (IntExp 2) (IdentifierExp "x"))))
   namespace
)

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (LetExp "x" (IntExp 1) (LetExp "y" (IntExp 2) (LetExp "x" (IntExp 3) (IdentifierExp "x")))))
   namespace
)

(assert-eval-equal? 
    5
    '(evaluate-in-empty-environment (LetExp "x" (IntExp 1) (LetExp "y" (IntExp 2) (LetExp "x" (IntExp 3) (AddExp (IdentifierExp "x") (IdentifierExp "y"))))))
   namespace
)


(suite-leave)