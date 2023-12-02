#lang racket

(require "../../../../core/racket/ibpl/graphviz/graphviz.rkt")
(require "../../../../core/racket/io/io.rkt")

(require "../core/ast.rkt")
(require "../list_converter/list_converter.rkt")
(require "../interpreter/interpreter.rkt")

(define (write-ast-to-file exp path)
  (let ([dot-text (ast-to-dot exp)])
    (begin
      (write-text-to-file dot-text path)
      (displayln (format "wrote ast to ~v" path)))))
      

(write-ast-to-file
 (racket-integers->ib-IntExps (list 1 2 3))
 "list_converter_1_2_3.dot")

(write-ast-to-file
 (LetExp "a" (IntExp 5) (AddExp (IdentifierExp "a") (IntExp 1)))
 "let.dot")

(write-ast-to-file
 (LetExp "sum_list" (FunctionExp "sum_list" "xs" (IfGreaterExp (IsNilExp (IdentifierExp "xs")) (IntExp 0) (IntExp 0) (AddExp (CarOfConsExp (IdentifierExp "xs")) (CallExp (IdentifierExp "sum_list") (CdrOfConsExp (IdentifierExp "xs")))))) (CallExp (IdentifierExp "sum_list") (ConsExp (IntExp 400) (ConsExp (IntExp 20) (ConsExp (IntExp 5) (NilExp))))))
 "call_sum_list.dot")

; uncomment when ready to debug macros and functions
; (require "../functions_and_macros/macros.rkt")
; (require "../functions_and_macros/functions.rkt")
; (write-ast-to-file
;  (IbIfNil (IdentifierExp "x") (IntExp 425) (IntExp 231))
;  "if_nil.dot")
