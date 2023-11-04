#lang racket
(provide (all-defined-out))
(require "../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../unit_testing/unit_testing.rkt")

(define (valid-ast? x)
  (cond [(IdentifierExp? x) (string? (IdentifierExp-name x))]
        [(IntExp? x) (exact-integer? (IntExp-value x))]
        [(AddExp? x) (and
                      (valid-ast? (AddExp-left_exp x))
                      (valid-ast? (AddExp-right_exp x)))]
        [(IfGreaterExp? x) (and
                      (valid-ast? (IfGreaterExp-left_exp x))
                      (valid-ast? (IfGreaterExp-right_exp x))
                      (valid-ast? (IfGreaterExp-then_body_exp x))
                      (valid-ast? (IfGreaterExp-else_body_exp x)))]
        [(NilExp? x) #t]
        [(IsNilExp? x) (valid-ast? (IsNilExp-exp x))]
        [(ConsExp? x) (and
                      (valid-ast? (ConsExp-car_exp x))
                      (valid-ast? (ConsExp-cdr_exp x)))]
        [(CarOfConsExp? x) (valid-ast? (CarOfConsExp-cons_exp x))]
        [(CdrOfConsExp? x) (valid-ast? (CdrOfConsExp-cons_exp x))]
        [(LetExp? x) (and
                      (string? (LetExp-binding_name x))
                      (valid-ast? (LetExp-binding_exp x))
                      (valid-ast? (LetExp-body_exp x)))]
        [(FunctionExp? x) (and
                           (or (string? (FunctionExp-name_option x)) (not (FunctionExp-name_option x)))
                           (string? (FunctionExp-parameter_name x))
                           (valid-ast? (FunctionExp-body_exp x)))]
        [(CallExp? x) (and
                      (valid-ast? (CallExp-function_exp x))
                      (valid-ast? (CallExp-argument_exp x)))]
        [#t (begin
            (displayln (~v x))
            #f)]))

(define (evaluate-in-empty-environment exp)
  (evaluate exp null))

(define (assert-valid-ast? x)
  (assert-true (valid-ast? x) (string-append "(valid-ast? " (~v x) ")")))

(define (assert-valid-ast-then-evaluate-in-empty-environment exp)
  (begin
    (assert-valid-ast? exp)
    (evaluate-in-empty-environment exp)))

