#lang racket
(require "../core/ast.rkt")
(provide (all-defined-out))

; Dekang Cao

; the inspiration for this assignment is MUPL
; https://drive.google.com/drive/u/1/folders/19cTksNZz470tYjIXzAiTURXiwi4N4DPG
; credit goes to Dan Grossman https://homes.cs.washington.edu/~djg/
; and his team at UW
; (struct IdentifierExp (name)                                           #:transparent)
; (struct IntExp        (value)                                          #:transparent)
; (struct AddExp        (left_exp right_exp)                             #:transparent)
; (struct IfGreaterExp  (left_exp right_exp then_body_exp else_body_exp) #:transparent)
; (struct NilExp        ()                                               #:transparent)
; (struct IsNilExp      (exp)                                            #:transparent)
; (struct ConsExp       (car_exp cdr_exp)                                #:transparent)
; (struct CarOfConsExp  (cons_exp)                                       #:transparent)
; (struct CdrOfConsExp  (cons_exp)                                       #:transparent)
; (struct LetExp        (binding_name binding_exp body_exp)              #:transparent)
; (struct FunctionExp   (name_option parameter_name body_exp)            #:transparent)
; (struct CallExp       (function_exp argument_exp)                      #:transparent)

(define (racket-integers->ib-IntExps xs)
  (cond
    ((null? xs) (NilExp)) 
    (else (ConsExp (IntExp (car xs)) (racket-integers->ib-IntExps (cdr xs))))))

(define (ib-IntExps->racket-integers xs)
  (cond
    ((NilExp? xs) '()) 
    (else (cons (IntExp-value(ConsExp-car_exp xs)) (ib-IntExps->racket-integers (ConsExp-cdr_exp xs))))))



