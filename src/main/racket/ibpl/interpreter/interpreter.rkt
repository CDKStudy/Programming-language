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
    ((null? v) #t) 
    ((pair? v)    
     (and (value? (car v)) (value? (cdr v)))) 
    ((exact-integer? v)  #t)
     ((closure? v) #t)
    (else #f)))   

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
  (if (and (string? name) (ensure-value? value) (list? env))
      (cons (entry name value) env)
      (exn:fail:contract)))



(define (evaluate exp env)
(cond[(IdentifierExp? exp)
  (cond
    [(null? env) (error "Identifier not found in environment" (IdentifierExp-name exp))]
    [(equal? (IdentifierExp-name exp) (entry-name (car env)))
     (entry-value (car env))]
    [else 
     (evaluate exp (cdr env))])]


     [(IntExp? exp) (IntExp-value exp)]

     [(AddExp? exp) (+ (evaluate (AddExp-left_exp exp) env) (evaluate (AddExp-right_exp exp) env))]

     [(NilExp? exp) '()]

     [(IsNilExp? exp) (if(null? (evaluate (IsNilExp-exp exp) env)) 1 0)]

     [(ConsExp? exp) (cons (evaluate (ConsExp-car_exp exp) env) (evaluate (ConsExp-cdr_exp exp) env))]

     [(CarOfConsExp? exp) (car (evaluate(CarOfConsExp-cons_exp exp) env))]
     [(CdrOfConsExp? exp) (cdr (evaluate(CdrOfConsExp-cons_exp exp) env))]

     [(IfGreaterExp? exp)
     (let ([left-val (evaluate (IfGreaterExp-left_exp exp) env)]
      [right-val (evaluate (IfGreaterExp-right_exp exp) env)])
     (if (> left-val right-val)
      (evaluate (IfGreaterExp-then_body_exp exp) env)
      (evaluate (IfGreaterExp-else_body_exp exp) env)))]

     [(FunctionExp? exp) (closure env exp)]


     [(LetExp? exp)
     (let* ([binding-name (LetExp-binding_name exp)]
     [binding-val (evaluate (LetExp-binding_exp exp) env)]) ; Evaluate the binding expression
     (let* ([new-env (cons (entry binding-name binding-val) env)]) ; Add the new binding to the environment
     (evaluate (LetExp-body_exp exp) new-env)))] ; Evaluate the body expression with the new environment
     

     
[(CallExp? exp)
  (let* ([function-val (evaluate (CallExp-function_exp exp) env)] ; Evaluate the function expression
         [argument-val (evaluate (CallExp-argument_exp exp) env)]) ; Evaluate the argument expression
    (if (closure? function-val)
        (let* ([function-exp (closure-function function-val)] ; Extract the function expression from the closure
               [function-env (closure-env function-val)] ; Extract the function's defining environment
               [param-name (FunctionExp-parameter_name function-exp)]) ; Extract the function's parameter name
          (let* ([new-env (expand-environment param-name argument-val function-env)]) ; Create a new environment for the function body
            (evaluate (FunctionExp-body_exp function-exp) new-env))) ; Evaluate the function body in the new environment
        (error "Not a function" function-val)))] ; Error if the evaluated function expression is not a closure

  [else (raise-argument-error 'exp "expression?" exp)])
)


