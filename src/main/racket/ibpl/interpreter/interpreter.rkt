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

     [(AddExp? exp)
     (cond
     [(NilExp? (AddExp-left_exp exp))(error "Lack expression")]
     [(NilExp? (AddExp-right_exp exp))(error "Lack expression")]
     [else (+ (evaluate (AddExp-left_exp exp) env) (evaluate (AddExp-right_exp exp) env))])]

     [(NilExp? exp) '()]

     [(IsNilExp? exp) (if(null? (evaluate (IsNilExp-exp exp) env)) 1 0)]

     [(ConsExp? exp) (cons (evaluate (ConsExp-car_exp exp) env) (evaluate (ConsExp-cdr_exp exp) env))]

     [(CarOfConsExp? exp)
     (cond
     [(IntExp? (CarOfConsExp-cons_exp exp))(error "is not List")]
     [else (car (evaluate(CarOfConsExp-cons_exp exp) env))])]

     [(CdrOfConsExp? exp)
     (cond
     [(IntExp? (CdrOfConsExp-cons_exp exp))(error "is not List")]
     [else(cdr (evaluate(CdrOfConsExp-cons_exp exp) env))])]

     [(IfGreaterExp? exp)
     (let ([left-val (evaluate (IfGreaterExp-left_exp exp) env)]
      [right-val (evaluate (IfGreaterExp-right_exp exp) env)])
     (if(or(null? left-val)(null? right-val)) 
     (error "lack exp")
      (if(> left-val right-val)
      (evaluate (IfGreaterExp-then_body_exp exp) env)
      (evaluate (IfGreaterExp-else_body_exp exp) env))))]

     [(FunctionExp? exp) (closure env exp)]


     [(LetExp? exp)
     (let* ([binding-name (LetExp-binding_name exp)]
     [binding-val (evaluate (LetExp-binding_exp exp) env)]) 
     (let* ([new-env (cons (entry binding-name binding-val) env)])
     (evaluate (LetExp-body_exp exp) new-env)))] 


[(CallExp? exp)
         (let ([v1 (evaluate (CallExp-function_exp exp) env)]
               [v2 (evaluate (CallExp-argument_exp exp) env)])
           (if (closure? v1)
               (let ([cfb (FunctionExp-body_exp (closure-function v1))] 
                      [fn (FunctionExp-name_option (closure-function v1))]
                      [fan (FunctionExp-parameter_name (closure-function v1))] 
                      [ce (closure-env v1)]) 
                 (evaluate cfb (if (equal? fn #f)
                                         (cons (entry fan v2) ce)
                                         (cons (entry fan v2) (cons (entry fn v1) ce))
                                         )))
               (error "IBPL call first argument is not a closure")))]

  [else (error "No exp")])
)


