#lang racket
;; Programming Languages Homework4 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

(require "../unit_testing/unit_testing.rkt")
(require "../../../main/racket/uw4/uw4.rkt")
(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(define ones (lambda () (cons 1 ones)))
(define a 2)

(suite-enter "uw4")

  ; sequence test
  (assert-eval-equal? 
  (list 0 1 2 3 4 5) 
  '(sequence 0 5 1) 
  namespace)

  ; string-append-map test
  (assert-eval-equal? 
  (list "dan.jpg" "dog.jpg" "curry.jpg" "dog2.jpg") 
  '(string-append-map '("dan" "dog" "curry" "dog2") ".jpg")
  namespace)

  ; list-nth-mod test
  (assert-eval-equal? 
  2 
  '(list-nth-mod (list 0 1 2 3 4) 2) 
  namespace)

  ; stream-for-n-steps test
  (assert-eval-equal? 
  (list 1 1) 
  '(stream-for-n-steps ones 2) 
  namespace)

  ; funny-number-stream test
  (assert-eval-equal? 
  (list 1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15 16) 
  '(stream-for-n-steps funny-number-stream 16) 
  namespace)

  ; dan-then-dog test
  (assert-eval-equal? 
  (list "dan.jpg") 
  '(stream-for-n-steps dan-then-dog 1) 
  namespace)

  ; stream-add-zero test
  (assert-eval-equal? 
  (list (cons 0 1)) 
  '(stream-for-n-steps (stream-add-zero ones) 1) 
  namespace)

  ; cycle-lists test
  (assert-eval-equal? 
  (list (cons 1 "a") (cons 2 "b") (cons 3 "a")) 
  '(stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b")) 3) 
  namespace)

  ; vector-assoc test
  (assert-eval-equal? 
  (cons 4 1)
  '(vector-assoc 4 (vector (cons 2 1) (cons 3 1) (cons 4 1) (cons 5 1)))  
  namespace)

  ; cached-assoc tests
  (assert-eval-equal? 
  (cons 3 4) 
  '((cached-assoc (list (cons 1 2) (cons 3 4)) 3) 3) 
  namespace)

  ; while-less test
  ; while-less test
  ; uncomment below for minimal test of challenge problem
 #; (assert-dethunk-equal? 
  #t
  (lambda () 
    (while-less 7 do (begin (set! a (+ a 1)) a))
    )
  "while-less 7 do (begin (set! a (+ a 1)) a)")

(suite-leave)
