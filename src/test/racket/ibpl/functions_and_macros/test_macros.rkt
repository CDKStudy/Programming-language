#lang racket
(require "../../unit_testing/unit_testing.rkt")

; (suite-enter "test_macros")

(require "./test_ib_if_nil.rkt")

(require "./test_ib_let_star.rkt")

; both if nil and let*
(require "./generated/test_evaluate_CallExp_factorial_via_count_down_and_product_list.rkt")
(require "./generated/test_evaluate_CallExp_product_list.rkt")

(require "./test_ib_if_eq.rkt")

; (suite-leave)
