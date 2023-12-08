#lang racket
(provide (all-defined-out))
(require "../core/ast.rkt")
(require "./macros.rkt")

; Dekang Cao

; the inspiration for this assignment is MUPL
; https://drive.google.com/drive/u/1/folders/19cTksNZz470tYjIXzAiTURXiwi4N4DPG
; credit goes to Dan Grossman https://homes.cs.washington.edu/~djg/
; and his team at UW

; racket version for reference
(define (racket-double n) (+ n n))

(define ib-double 
  (FunctionExp #f "x" (AddExp (IdentifierExp "x") (IdentifierExp "x"))))



; racket version for reference
(define (racket-sum-curry a) (lambda (b) (+ a b)))

(define ib-sum-curry
  (FunctionExp #f "a"
    (FunctionExp #f "b"
      (AddExp (IdentifierExp "a") (IdentifierExp "b")))))


; racket version for reference
(define (racket-call-with-one proc) (proc 1))

(define ib-call-with-one
  (FunctionExp #f "proc"
    (CallExp (IdentifierExp "proc") (IntExp 1))))

(define ib-map



  (FunctionExp #f "f"
    (FunctionExp "ib-map" "lst"
      (IbIfNil (IdentifierExp "lst")
        (NilExp) ; return empty list if lst is NilExp
        (ConsExp ; otherwise, construct a new list
          (CallExp (IdentifierExp "f") ; apply the function f to the first element of the list
                   (CarOfConsExp (IdentifierExp "lst")))
          (CallExp ; and recursively call ib-map on the rest of the list
             (IdentifierExp "ib-map")
            (CdrOfConsExp (IdentifierExp "lst"))            
            ))))))


(define ib-map-add-n
  (LetExp "map" ib-map
    (FunctionExp #f "i"
      (FunctionExp #f "lst"
        (CallExp
          (CallExp (IdentifierExp "map")
            (FunctionExp #f "elem"
              (AddExp (IdentifierExp "elem") (IdentifierExp "i"))))
          (IdentifierExp "lst"))))))

