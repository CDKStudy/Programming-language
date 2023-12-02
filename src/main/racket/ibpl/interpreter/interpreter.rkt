#lang racket
(provide (all-defined-out))
(require "../core/ast.rkt")

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

(struct closure (env function) #:transparent)

(define (value? v)
  (cond
    ((null? v) #t) ; Null values are allowed
    ((pair? v)     ; Check if it's a pair
     (and (value? (car v)) (value? (cdr v)))) ; Recursively check car and cdr
    ((exact-integer? v)  ; Check if it's an exact integer
     #t)
     ((closure? v) #t)
    (else #f)))    ; Anything else returns false




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
