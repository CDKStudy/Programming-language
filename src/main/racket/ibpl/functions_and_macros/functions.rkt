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
        'not-yet-implemented) 

; racket version for reference
(define (racket-sum-curry a) (lambda (b) (+ a b)))

(define ib-sum-curry
        'not-yet-implemented) 

; racket version for reference
(define (racket-call-with-one proc) (proc 1))

(define ib-call-with-one
        'not-yet-implemented) 

(define ib-map 
        'not-yet-implemented) 

(define ib-map-add-n 
  (LetExp "map" ib-map
                'not-yet-implemented-notice-map-is-now-in-IBPL-scope)) 
