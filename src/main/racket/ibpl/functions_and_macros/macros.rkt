#lang racket
(provide (all-defined-out))
(require "../core/ast.rkt")

; __STUDENT_NAME__

; the inspiration for this assignment is MUPL
; https://drive.google.com/drive/u/1/folders/19cTksNZz470tYjIXzAiTURXiwi4N4DPG
; credit goes to Dan Grossman https://homes.cs.washington.edu/~djg/
; and his team at UW

(define (IbIfNil exp then_body_exp else_body_exp)
        (error 'not-yet-implemented)) 


(struct binding (name exp) #:transparent)

(define (IbLet* bindings body_exp) 
        (error 'not-yet-implemented)) 

(define (IbIfEq left_exp right_exp then_body_exp else_body_exp) 
        (error 'not-yet-implemented)) 

