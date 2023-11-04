#lang racket
(provide (all-defined-out))
(require "../core/ast.rkt")

; Dekang Cao

; the inspiration for this assignment is MUPL
; https://drive.google.com/drive/u/1/folders/19cTksNZz470tYjIXzAiTURXiwi4N4DPG
; credit goes to Dan Grossman https://homes.cs.washington.edu/~djg/
; and his team at UW


(struct closure (env function) #:transparent)

(define (value? v)
        (error 'not-yet-implemented)) 


(define (ensure-value? v)
  (if (value? v)
      v
      (raise-argument-error 'v "value?" v)))

(struct entry (name value) #:transparent)

(define (lookup-value-in-environment env identifier-name)
  (cond [(null? env) (error "unbound identifier during evaluation" identifier-name)]
        [(equal? (entry-name (car env)) identifier-name) (entry-value (car env))]
        [#t (lookup-value-in-environment (cdr env) identifier-name)]))

(define (expand-environment name value env)
        (error 'not-yet-implemented)) 

(define (evaluate exp env)
  (if (expression? exp)
      (if (list? env)
          (ensure-value? 
                 (error 'not-yet-implemented))
          (raise-argument-error 'env "list?" env))
      (raise-argument-error 'exp "expression?" exp)))
