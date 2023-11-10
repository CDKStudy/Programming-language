#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_1 = 
;   null(
;     let
;       val unused = 425
;     in
;       nil
;     end
;   )
; 
; val eq_1 = 
;   null(
;     let
;       val x = nil
;     in
;       x
;     end
;   )
; 
; val eq_0 = 
;   null(
;     let
;       val x = 425
;     in
;       x
;     end
;   )
; 
; val eq_0 = 
;   let
;     val unused = nil 
;   in
;     null(425)
;   end
; 
; 
; val eq_1 = 
;   let
;     val unused = 425 
;   in
;     null(nil)
;   end
; 
; val eq_1 = 
;   let
;     val x = nil 
;   in
;     null(x)
;   end


(suite-enter "test_evaluate_LetExp_IsNilExp_combined")

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (IsNilExp (LetExp "unused" (IntExp 425) (NilExp))))
   namespace
)

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (IsNilExp (LetExp "x" (NilExp) (IdentifierExp "x"))))
   namespace
)

(assert-eval-equal? 
    0
    '(evaluate-in-empty-environment (IsNilExp (LetExp "x" (IntExp 425) (IdentifierExp "x"))))
   namespace
)

(assert-eval-equal? 
    0
    '(evaluate-in-empty-environment (LetExp "unused" (NilExp) (IsNilExp (IntExp 425))))
   namespace
)

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (LetExp "unused" (IntExp 425) (IsNilExp (NilExp))))
   namespace
)

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (LetExp "x" (NilExp) (IsNilExp (IdentifierExp "x"))))
   namespace
)


(suite-leave)