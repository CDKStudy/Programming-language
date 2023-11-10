#lang racket
(require "../../../../../main/racket/ibpl/core/ast.rkt")
(require "../../../../../main/racket/ibpl/interpreter/interpreter.rkt")
(require "../../util/utils.rkt")
(require "../../../unit_testing/unit_testing.rkt")

(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))


; translated from SML
;
; val eq_1 = hd([1,2,3,4,5])
; val eq_2 = hd(tl([1,2,3,4,5]))
; val eq_3 = hd(tl(tl([1,2,3,4,5])))
; val eq_4 = hd(tl(tl(tl([1,2,3,4,5]))))
; val eq_5 = hd(tl(tl(tl(tl[1,2,3,4,5]))))
; 
; val expected_2345 = "(list 2 3 4 5)"
; val eq_expected_2345 = tl([1,2,3,4,5])
; 
; val expected_345 = "(list 3 4 5)"
; val eq_expected_345 = tl(tl([1,2,3,4,5]))
; 
; val expected_45 = "(list 4 5)"
; val eq_expected_45 = tl(tl(tl([1,2,3,4,5])))
; 
; val expected_5 = "(list 5)"
; val eq_expected_5 = tl(tl(tl(tl([1,2,3,4,5]))))
; 
; val eq_null = tl(tl(tl(tl(tl([1,2,3,4,5])))))


(suite-enter "test_evaluate_CarCdrExps_deep")

(assert-eval-equal? 
    1
    '(evaluate-in-empty-environment (CarOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp))))))))
   namespace
)

(assert-eval-equal? 
    2
    '(evaluate-in-empty-environment (CarOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp)))))))))
   namespace
)

(assert-eval-equal? 
    3
    '(evaluate-in-empty-environment (CarOfConsExp (CdrOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp))))))))))
   namespace
)

(assert-eval-equal? 
    4
    '(evaluate-in-empty-environment (CarOfConsExp (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp)))))))))))
   namespace
)

(assert-eval-equal? 
    5
    '(evaluate-in-empty-environment (CarOfConsExp (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp))))))))))))
   namespace
)


(assert-eval-equal? 
    (list 2 3 4 5)
    '(evaluate-in-empty-environment (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp))))))))
   namespace
)


(assert-eval-equal? 
    (list 3 4 5)
    '(evaluate-in-empty-environment (CdrOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp)))))))))
   namespace
)


(assert-eval-equal? 
    (list 4 5)
    '(evaluate-in-empty-environment (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp))))))))))
   namespace
)


(assert-eval-equal? 
    (list 5)
    '(evaluate-in-empty-environment (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp)))))))))))
   namespace
)

(assert-eval-equal? 
    null
    '(evaluate-in-empty-environment (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (CdrOfConsExp (ConsExp (IntExp 1) (ConsExp (IntExp 2) (ConsExp (IntExp 3) (ConsExp (IntExp 4) (ConsExp (IntExp 5) (NilExp))))))))))))
   namespace
)


(suite-leave)