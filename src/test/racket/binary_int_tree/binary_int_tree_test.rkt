#lang racket
(require "../../../main/racket/binary_int_tree/binary_int_tree.rkt")
(require "../unit_testing/unit_testing.rkt")
(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

(suite-enter "binary_int_tree_tests")

(suite-enter "contains")
   (assert-eval-false '(contains empty-tree 425) namespace)
   (assert-eval-true '(contains (branch #f 425 #f) 425) namespace)
   (assert-eval-false '(contains (branch #f 425 #f) 231) namespace)
   (assert-eval-true '(contains (branch (branch #f 231 #f) 425 #f) 425) namespace)
   (assert-eval-true '(contains (branch (branch #f 231 #f) 425 #f) 231) namespace)
   (assert-eval-false '(contains (branch (branch #f 231 #f) 425 #f) 42) namespace)
   (assert-eval-true '(contains (branch #f 231 (branch #f 425 #f)) 425) namespace)
   (assert-eval-true '(contains (branch #f 231 (branch #f 425 #f)) 231) namespace)
   (assert-eval-false '(contains (branch #f 231 (branch #f 425 #f)) 42) namespace)
(suite-leave)

(define (fold-rnl f init tree)
  (if (branch? tree)
      (local {(define acc (fold-rnl f init (branch-right tree)))
              (define acc-prime (f (branch-x tree) acc))
              (define acc-prime-prime (fold-rnl f acc-prime (branch-left tree)))}
        acc-prime-prime)
      init))

(define (to-list tree)
  (fold-rnl cons null tree))

(define (insert-all xs)
  (foldl (lambda (x tree) (insert tree x)) empty-tree xs))

(define t (insert-all (list 8 6 7 5 3 0 9)))

(suite-enter "insert")
   (assert-eval-equal? '(425) '(to-list (insert empty-tree 425)) namespace)
   (assert-eval-equal? '(231 425) '(to-list (insert (insert empty-tree 425) 231)) namespace)
   (assert-eval-equal? '(231 300 425) '(to-list (insert (insert (insert empty-tree 425) 231) 300)) namespace)
   (assert-eval-equal? '(42 231 300 425) '(to-list (insert (insert (insert (insert empty-tree 425) 231) 300) 42)) namespace)
   (assert-eval-true '(contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 425) namespace)
   (assert-eval-true '(contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 231) namespace)
   (assert-eval-true '(contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 300) namespace)
   (assert-eval-true '(contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 42) namespace)
   (assert-eval-false '(contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 7) namespace)

   (assert-eval-equal? '(0 3 5 6 7 8 9) '(to-list (insert-all '(8 6 7 5 3 0 9))) namespace)
(suite-leave)

(suite-enter "sum")
   (assert-eval-equal? 0 '(sum empty-tree) namespace)
   (assert-eval-equal? 425 '(sum (insert empty-tree 425)) namespace)
   (assert-eval-equal? 656 '(sum (insert-all '(425 231))) namespace)
   (assert-eval-equal? 956 '(sum (insert-all '(300 425 231))) namespace)
   (assert-eval-equal? 998 '(sum (insert-all '(425 42 300 231))) namespace)
   (assert-eval-equal? 38 '(sum (insert-all '(8 6 7 5 3 0 9))) namespace)
(suite-leave)

(suite-leave)
