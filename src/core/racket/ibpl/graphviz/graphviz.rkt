#lang racket
(provide (all-defined-out))

(require "../../../../main/racket/ibpl/core/ast.rkt")

(define (ast-to-dot exp)
  (local [(define prefix "
digraph {

graph [
    nodesep=\"0.5\"
    ranksep=\"1.0\"
    splines=\"curved\"
];

node [
    shape = \"record\"
    style = \"filled\"
    fillcolor = \"#DDDDFF\"
    fontname = \"Courier\"
    width = 1.0
    align = LEFT
];

edge [
    tailclip=false,
    arrowhead=vee, 
    arrowtail=dot, 
    dir=both
];
")

          (define (to-procedure-name proc)
            (substring (~a proc) 12 (- (string-length (~a proc)) 1)))

          (define (field-to-string field-name v correct-type?)
            (format "{~a\\l|~a}" field-name (if (correct-type? v)
                                                (if (expression? v)
                                                    (format "<~a>" field-name)
                                                    (if (string? v)
                                                        (format "\\\"~a\\\"" v)
                                                        (format "~a" v)))
                                                (format "!!! INCORRECT TYPE !!!\\l======================\\lexpected ~a\\lactual value: ~a\\l" (to-procedure-name correct-type?) v))))

          (define (output-nodes exp prefix)
            (if (expression? exp)
                (cond [(IdentifierExp? exp)
                       (let ([name (IdentifierExp-name exp)])
                         (format "~a [\n\tlabel = \"{IdentifierExp\\l|~a}\"\n]\n" prefix (field-to-string "name" name string?)))]
                      [(IntExp? exp)
                       (let ([value (IntExp-value exp)])
                         (format "~a [\n\tlabel = \"{IntExp\\l|~a}\"\n]\n" prefix (field-to-string "value" value exact-integer?)))]
                      [(AddExp? exp)
                       (let ([left-exp (AddExp-left_exp exp)]
                             [right-exp (AddExp-right_exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{AddExp\\l|~a|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "left_exp" left-exp expression?)
                                  (field-to-string "right_exp" right-exp expression?))
                          (output-nodes left-exp (format "~a_left" prefix))
                          (output-nodes right-exp (format "~a_right" prefix))
                          ))]
                      [(IfGreaterExp? exp)
                       (let ([left-exp (IfGreaterExp-left_exp exp)]
                             [right-exp (IfGreaterExp-right_exp exp)]
                             [then-body-exp (IfGreaterExp-then_body_exp exp)]
                             [else-body-exp (IfGreaterExp-else_body_exp exp)])
                         (list
                          (format "~a [\n\twidth = 2.5\n\tlabel = \"{IfGreaterExp\\l|~a|~a|~a|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "left_exp" left-exp expression?)
                                  (field-to-string "right_exp" right-exp expression?)
                                  (field-to-string "then_body_exp" then-body-exp expression?)
                                  (field-to-string "else_body_exp" else-body-exp expression?))
                          (output-nodes left-exp (format "~a_left" prefix))
                          (output-nodes right-exp (format "~a_right" prefix))
                          (output-nodes then-body-exp (format "~a_then" prefix))
                          (output-nodes else-body-exp (format "~a_else" prefix))
                          ))]
                      [(NilExp? exp)             
                       (format "~a [\n\tlabel = \"{NilExp\\l}\"\n]\n" prefix)]
                      [(IsNilExp? exp)
                       (let ([child-exp (IsNilExp-exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{IsNilExp\\l|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "exp" child-exp expression?))
                          (output-nodes child-exp (format "~a_exp" prefix))
                          ))]
                      [(ConsExp? exp)
                       (let ([car-exp (ConsExp-car_exp exp)]
                             [cdr-exp (ConsExp-cdr_exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{ConsExp\\l|~a|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "car_exp" car-exp expression?)
                                  (field-to-string "cdr_exp" cdr-exp expression?))
                          (output-nodes car-exp (format "~a_car" prefix))
                          (output-nodes cdr-exp (format "~a_cdr" prefix))
                          ))]
                      [(CarOfConsExp? exp)
                       (let ([cons-exp (CarOfConsExp-cons_exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{CarOfConsExp\\l|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "cons_exp" cons-exp expression?))
                          (output-nodes cons-exp (format "~a_cons_exp" prefix))
                          ))]
                      [(CdrOfConsExp? exp)
                       (let ([cons-exp (CdrOfConsExp-cons_exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{CdrOfConsExp\\l|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "cons_exp" cons-exp expression?))
                          (output-nodes cons-exp (format "~a_cons_exp" prefix))
                          ))]
                      [(LetExp? exp)
                       (let ([binding-name (LetExp-binding_name exp)]
                             [binding-exp (LetExp-binding_exp exp)]
                             [body-exp (LetExp-body_exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{LetExp\\l|~a|~a|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "binding_name" binding-name string?)
                                  (field-to-string "binding_exp" binding-exp expression?)
                                  (field-to-string "body_exp" body-exp expression?))
                          (output-nodes binding-exp (format "~a_binding" prefix))
                          (output-nodes body-exp (format "~a_body" prefix))
                          ))]
                      [(FunctionExp? exp)
                       (let ([name-option (FunctionExp-name_option exp)]
                             [parameter-name (FunctionExp-parameter_name exp)]
                             [body-exp (FunctionExp-body_exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{FunctionExp\\l|~a|~a|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "name_option" name-option (lambda (v) (or (string? v) (boolean? v))))
                                  (field-to-string "parameter_name" parameter-name string?)
                                  (field-to-string "body_exp" body-exp expression?))
                          (output-nodes name-option (format "~a_name_option" prefix))
                          (output-nodes parameter-name (format "~a_parameter_name" prefix))
                          (output-nodes body-exp (format "~a_body" prefix))
                          ))]
                      [(CallExp? exp)
                       (let ([function-exp (CallExp-function_exp exp)]
                             [argument-exp (CallExp-argument_exp exp)])
                         (list
                          (format "~a [\n\tlabel = \"{CallExp\\l|~a|~a}\"\n]\n"
                                  prefix
                                  (field-to-string "function_exp" function-exp expression?)
                                  (field-to-string "argument_exp" argument-exp expression?))
                          (output-nodes function-exp (format "~a_function" prefix))
                          (output-nodes argument-exp (format "~a_argument" prefix))
                          ))]
                      [#t (raise (format "~a" exp))]
                      )
                ""))

          (define (output-edges exp prefix)
            (if (expression? exp)
                (cond [(IdentifierExp? exp)
                       null]
                      [(IntExp? exp)
                       null]
                      [(AddExp? exp)
                       (let ([left-exp (AddExp-left_exp exp)]
                             [right-exp (AddExp-right_exp exp)])
                         (list
                          (output-edges left-exp (format "~a_left" prefix))
                          (output-edges right-exp (format "~a_right" prefix))
                          (if (expression? left-exp) (format "~a:left_exp:c -> ~a_left:c\n" prefix prefix) "")
                          (if (expression? right-exp) (format "~a:right_exp:c -> ~a_right:c\n" prefix prefix) "")
                          ))]
                      [(IfGreaterExp? exp)
                       (let ([left-exp (IfGreaterExp-left_exp exp)]
                             [right-exp (IfGreaterExp-right_exp exp)]
                             [then-body-exp (IfGreaterExp-then_body_exp exp)]
                             [else-body-exp (IfGreaterExp-else_body_exp exp)])
                         (list
                          (output-edges left-exp (format "~a_left" prefix))
                          (output-edges right-exp (format "~a_right" prefix))
                          (output-edges then-body-exp (format "~a_then" prefix))
                          (output-edges else-body-exp (format "~a_else" prefix))
                          (if (expression? left-exp) (format "~a:left_exp:c -> ~a_left\n" prefix prefix) "")
                          (if (expression? right-exp) (format "~a:right_exp:c -> ~a_right\n" prefix prefix) "")
                          (if (expression? then-body-exp) (format "~a:then_body_exp:c -> ~a_then\n" prefix prefix) "")
                          (if (expression? else-body-exp) (format "~a:else_body_exp:c -> ~a_else\n" prefix prefix) "")
                          ))]
                      [(NilExp? exp)
                       null]
                      [(IsNilExp? exp)
                       (let ([child-exp (IsNilExp-exp exp)])
                         (list
                          (output-edges child-exp (format "~a_exp" prefix))
                          (if (expression? child-exp) (format "~a:exp:c -> ~a_exp\n" prefix prefix) "")
                          ))]
                      [(ConsExp? exp)
                       (let ([car-exp (ConsExp-car_exp exp)]
                             [cdr-exp (ConsExp-cdr_exp exp)])
                         (list
                          (output-edges car-exp (format "~a_car" prefix))
                          (output-edges cdr-exp (format "~a_cdr" prefix))
                          (if (expression? car-exp) (format "~a:car_exp:c -> ~a_car:c\n" prefix prefix) "")
                          (if (expression? cdr-exp) (format "~a:cdr_exp:c -> ~a_cdr:c\n" prefix prefix) "")
                          ))]
                      [(CarOfConsExp? exp)
                       (let ([cons-exp (CarOfConsExp-cons_exp exp)])
                         (list
                          (output-edges cons-exp (format "~a_cons_exp" prefix))
                          (if (expression? cons-exp) (format "~a:cons_exp:c -> ~a_cons_exp\n" prefix prefix) "")
                          ))]
                      [(CdrOfConsExp? exp)
                       (let ([cons-exp (CdrOfConsExp-cons_exp exp)])
                         (list
                          (output-edges cons-exp (format "~a_cons_exp" prefix))
                          (if (expression? cons-exp) (format "~a:cons_exp:c -> ~a_cons_exp\n" prefix prefix) "")
                          ))]
                      [(LetExp? exp)
                       (let ([binding-exp (LetExp-binding_exp exp)]
                             [body-exp (LetExp-body_exp exp)])
                         (list
                          (output-edges binding-exp (format "~a_binding" prefix))
                          (output-edges body-exp (format "~a_body" prefix))
                          (if (expression? binding-exp) (format "~a:binding_exp:c -> ~a_binding:c\n" prefix prefix) "")
                          (if (expression? body-exp) (format "~a:body_exp:c -> ~a_body:c\n" prefix prefix) "")
                          ))]
                      [(FunctionExp? exp)
                       (let ([body-exp (FunctionExp-body_exp exp)])
                         (list
                          (output-edges body-exp (format "~a_body" prefix))
                          (if (expression? body-exp) (format "~a:body_exp:c -> ~a_body:c\n" prefix prefix) "")
                          ))]
                      [(CallExp? exp)
                       (let ([function-exp (CallExp-function_exp exp)]
                             [argument-exp (CallExp-argument_exp exp)])
                         (list
                          (output-edges function-exp (format "~a_function" prefix))
                          (output-edges argument-exp (format "~a_argument" prefix))
                          (if (expression? function-exp) (format "~a:function_exp:c -> ~a_function:c\n" prefix prefix) "")
                          (if (expression? argument-exp) (format "~a:argument_exp:c -> ~a_argument:c\n" prefix prefix) "")
                          ))]
                      [#t (raise (format "~a" exp))])
                ""))


          (define (append x acc)
            (cond [(string? x) (string-append x acc)]
                  [(list? x) (foldl append acc x)]))

          (define nodes-text (foldl append "" (output-nodes exp "root")))
          (define edges-text (foldl append "" (output-edges exp "root")))
          ]
    (string-join (list prefix nodes-text edges-text "}") "")))
