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
; val eq_425 = 
;   let 
;     val m = 400
;     val n = 25
;   in
;     m + n
;   end


(suite-enter "test_let_star_preliminary")

(assert-eval-equal? 
    425
    '(evaluate-in-empty-environment (IbLet* (list (binding "m" (IntExp 400)) (binding "n" (IntExp 25)) ) (AddExp (IdentifierExp "m") (IdentifierExp "n"))))
   namespace
)


(suite-leave)