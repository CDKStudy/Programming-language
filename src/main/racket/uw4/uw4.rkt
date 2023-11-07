
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; Dekang Cao

; Complete WashU Thunk and Stream WarmUp Below

; CSE 425 Utility Function
(define (thunk? th) 
        (error 'not-yet-implemented)) 

; CSE 425 Utility Macro
; NOTE: macros use define-syntax-rule
(define-syntax-rule (thunk-that e)
        (error 'not-yet-implemented)) 

; CSE 425 Utility Function
(define (dethunk-that thunk)
        (error 'not-yet-implemented))

; CSE 425 Utility Function
(define (destream stream)
        (error 'not-yet-implemented)) 

; CSE 425 Utility Function
(define (cons-with-thunk-check-on-next-stream element next-stream)
        (error 'not-yet-implemented)) 

; Complete UW HW4 Below
;1
(define (sequence low high stride)
(if (> low high)
  null
  (cons low(sequence (+ low stride) high stride))))
;2
(define (string-append-map xs suffix)
(map (lambda (val) (string-append val suffix)) xs))
;3
(define (list-nth-mod xs n)
(cond
    [(< n 0) (error "list-nth-mod: negative number")]
    [(null? xs) (error "list-nth-mod: empty list")]
    [#t (car (list-tail xs (remainder n (length xs))))]))
;4
(define (stream-for-n-steps s n)
(if (= n 0)
  null
  (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))
;5
(define (funny-number-stream)
(let f ((n 1))
(cons (if (= (remainder n 5) 0)
        (- n)
        n)
        (lambda () (f (+ n 1))))))
;6
(define dan-then-dog
  (letrec ([f1 (lambda () (cons "dan.jpg" f2))]
           [f2 (lambda () (cons "dog.jpg" f1))])f1))
;7
(define (stream-add-zero s)
(lambda () (let ((n (s)))
(cons (cons 0 (car n)) (stream-add-zero (cdr n))))))
;8
(define (cycle-lists xs ys)
(letrec ([f (lambda (n) 
  (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda () (f (+ n 1)))))])
  (lambda () (f 0))))
;9
(define (vector-assoc v vec)
(letrec ([f (lambda (i)
  (if (>= i (vector-length vec))
  #f (let ([element (vector-ref vec i)])
    (if (and (pair? element) (equal? (car element) v))
    element (f (+ 1 i))))))])(f 0)))
;10
(define (cached-assoc xs n)
(let ([cache (make-vector n #f)] [index 0]) 
(lambda (v)
  (let ([v1 (vector-assoc v cache)])
    (if (not (equal? v1 #f))
      v1
      (let ([v2 (assoc v xs)])
      (when (not (equal? v2 #f)) 
        (vector-set! cache index v2)
        (set! index (modulo (+ 1 index) n))) v2))))))





