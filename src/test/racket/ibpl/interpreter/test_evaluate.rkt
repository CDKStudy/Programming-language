#lang racket

(require "./test_evaluate_IdentifierExp.rkt")

(require "./generated/test_evaluate_IntExp.rkt")

(require"./generated/test_evaluate_AddExp_preliminary.rkt")

(require "./generated/test_evaluate_NilExp_preliminary.rkt")

(require "./generated/test_evaluate_IsNilExp_preliminary.rkt")

(require "./generated/test_evaluate_ConsExp_preliminary.rkt")
(require "./generated/test_evaluate_ConsExp_pair.rkt")

(require "./generated/test_evaluate_CarCdrExps_preliminary.rkt")
(require "./generated/test_evaluate_CarCdrExps_pair.rkt")
(require "./generated/test_evaluate_CarCdrExps_deep.rkt")

(require "./generated/test_evaluate_IfGreaterExp_preliminary.rkt")
(require "./test_evaluate_IfGreaterExp_either_or.rkt")

(require "./test_evaluate_FunctionExp.rkt")

(require "./generated/test_evaluate_LetExp_preliminary.rkt")
(require "./generated/test_evaluate_LetExp_nested.rkt")
(require "./generated/test_evaluate_LetExp_shadowed.rkt")

(require "./generated/test_evaluate_LetExp_AddExp_combined.rkt")
(require "./generated/test_evaluate_LetExp_IsNilExp_combined.rkt")
(require "./generated/test_evaluate_LetExp_ConsExp_combined.rkt")

(require "./generated/test_evaluate_CallExp_ten.rkt")
(require "./generated/test_evaluate_CallExp_identity.rkt")
(require "./generated/test_evaluate_CallExp_double.rkt")
(require "./generated/test_evaluate_CallExp_increment.rkt")
(require "./generated/test_evaluate_CallExp_add_to_x.rkt")
(require "./generated/test_evaluate_CallExp_add_to_x_shadowed.rkt")
(require "./generated/test_evaluate_CallExp_sum_a_b.rkt")
(require "./generated/test_evaluate_CallExp_length_list.rkt")
(require "./generated/test_evaluate_CallExp_sum_list.rkt")
(require "./generated/test_evaluate_CallExp_multiply.rkt")
(require "./generated/test_evaluate_CallExp_factorial.rkt")
(require "./generated/test_evaluate_CallExp_count_down.rkt")
(require "./generated/test_evaluate_CallExp_product_list.rkt")
(require "./generated/test_evaluate_CallExp_factorial_via_count_down_and_product_list.rkt")

(require "./test_evaluate_AddExp_malformed.rkt")
(require "./test_evaluate_CarExp_malformed.rkt")
(require "./test_evaluate_CdrExp_malformed.rkt")
(require "./test_evaluate_IfGreaterExp_malformed.rkt")
(require "./test_evaluate_CallExp_malformed.rkt")
