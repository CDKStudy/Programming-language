#lang racket
(provide (all-defined-out))
(require "../core/ast.rkt")

; Dekang Cao

; the inspiration for this assignment is MUPL
; https://drive.google.com/drive/u/1/folders/19cTksNZz470tYjIXzAiTURXiwi4N4DPG
; credit goes to Dan Grossman https://homes.cs.washington.edu/~djg/
; and his team at UW

(define (IbIfNil exp then_body_exp else_body_exp)
  (IfGreaterExp (IsNilExp exp) 
                (IntExp 0) 
                then_body_exp
                else_body_exp))



(struct binding (name exp) #:transparent)

(define (IbLet* bindings body_exp)
  (if (null? bindings)
      body_exp
      (let ((b (car bindings)))
        (LetExp (binding-name b) 
                (binding-exp b) 
                (IbLet* (cdr bindings) body_exp)))))

(define (IbIfEq left_exp right_exp then_body_exp else_body_exp)
  (LetExp "_x" left_exp
    (LetExp "_y" right_exp
      (IfGreaterExp (IdentifierExp "_x") 
        (IdentifierExp "_y") 
         else_body_exp
        (IfGreaterExp (IdentifierExp "_y") 
                (IdentifierExp "_x") 
                else_body_exp
                then_body_exp)))))


