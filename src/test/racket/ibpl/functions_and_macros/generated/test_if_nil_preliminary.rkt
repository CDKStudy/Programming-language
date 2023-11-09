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
; val eq_131 =
;   if null(nil)
;   then 131
;   else 231
; 
; val eq_231 =
;   if null(425)
;   then 131
;   else 231


(suite-enter "test_if_nil_preliminary")

(assert-eval-equal? 
    131
    '(evaluate-in-empty-environment (IbIfNil (NilExp) (IntExp 131) (IntExp 231)))
   namespace
)

(assert-eval-equal? 
    231
    '(evaluate-in-empty-environment (IbIfNil (IntExp 425) (IntExp 131) (IntExp 231)))
   namespace
)


(suite-leave)