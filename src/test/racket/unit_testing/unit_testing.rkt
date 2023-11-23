#lang racket
(require racket/exn)

(provide (all-defined-out))

(define include-case-info (make-parameter #t))
 
(command-line
 #:once-each
 [("-o" "--omit-case-info") "omit case info in unit test output" (include-case-info #f)]
 )

(define (to-case-message message) (if (include-case-info) message "OMITTED"))

(define suite-name-stack (list))

(define (push-suite-name name)
  (set! suite-name-stack (cons name suite-name-stack)))

(define (pop-suite-name)
  (let ([x (car suite-name-stack)])
    (begin
      (set! suite-name-stack (cdr suite-name-stack))
      x)))

(define (indented-displayln datum port)
  (begin
    (for ([unused (length suite-name-stack)]) (display "\t" port))
    (displayln datum port)))

(define (indented-outln datum)
  (indented-displayln datum (current-output-port)))

(define (indented-errln datum)
  (indented-displayln datum (current-error-port)))

(define (assert-condition f description expected actual message)
  (if (f actual)
    (begin
      (indented-outln (string-append "      success. " description))
      (indented-outln (string-append "         case: " (to-case-message message)))
      (indented-outln (string-append "  as expected: " (~v expected)))
      (indented-outln "")
    )
    (begin
      (indented-errln (string-append "    FAILURE!!! " description))
      (indented-errln (string-append "         case: " (to-case-message message)))
      (indented-errln (string-append "     expected: " (~v expected)))
      (indented-errln (string-append "       actual: " (~v actual)))
      (indented-errln "")

      (error (string-append "expected: " (~v expected) "; actual: " (~v actual)))
      )
    )
  )

(define (assert-equal? expected actual message)
  (assert-condition (lambda (actual) (equal? expected actual)) "assert-equal?" expected actual message))

(define (assert-eval-equal? expected top-level-form namespace)
  (assert-equal? expected (eval top-level-form namespace) (~v top-level-form)))

; investigate eval-syntax
(define (assert-dethunk-equal? expected thunk message)
  (assert-equal? expected (thunk) message))


(define (assert-true actual message)
  (assert-condition (lambda (actual) (equal? #t actual)) "assert-true" #t actual message))

(define (assert-eval-true top-level-form namespace)
  (assert-true (eval top-level-form namespace) (~v top-level-form)))

(define (assert-false actual message)
  (assert-condition (lambda (actual) (equal? #f actual)) "assert-false" #f actual message))

(define (assert-eval-false top-level-form namespace)
  (assert-false (eval top-level-form namespace) (~v top-level-form)))

(define (assert-eval-exn exn-predicate top-level-form namespace)
  (let* (
        [unique-exn-match (mcons 425 231)]
        [top-level-form-text (~v top-level-form)]
        [actual
         (with-handlers
             ([exn-predicate (lambda (exn)
                               (begin
                                 (indented-outln (string-append "      success. assert-eval-exn"))
                                 (indented-outln (string-append "         case: " (to-case-message top-level-form-text)))
                                 (indented-outln (string-append "  as expected: " (~v exn-predicate)))
                                 (indented-outln "")
                                 unique-exn-match))]
              [exn:fail? (lambda (exn)
               (begin
                 (indented-errln (string-append "    FAILURE!!! assert-eval-exn"))
                 (indented-errln (string-append "         case: " (to-case-message top-level-form-text)))
                 (indented-errln (string-append "     expected: " (~v exn-predicate)))
                 (indented-errln (string-append "       actual: different exception " (exn->string exn)))
                 (indented-errln "")
                 (error (string-append "expected: " (~v exn-predicate) "; actual: different exception " (exn->string exn)))))])
           (eval top-level-form namespace))
         ])
    (if (eq? actual unique-exn-match)
        (void)
        (begin
          (indented-errln (string-append "    FAILURE!!! assert-eval-exn"))
          (indented-errln (string-append "         case: " (to-case-message top-level-form-text)))
          (indented-errln (string-append "     expected: " (~v exn-predicate)))
          (indented-errln (string-append "       actual: no exception, " (~v actual)))
          (indented-errln "")
          (error "expected: " (~v exn-predicate) "; actual: no exception, " (~v actual))))))
        

(define (assert-within expected actual delta message)
  (assert-condition (lambda (actual) (<= (magnitude (- expected actual)) delta)) "assert-within" expected actual message))

(define (assert-eval-within expected top-level-form delta namespace)
  (assert-within expected (eval top-level-form namespace) delta (~v top-level-form)))

(define (suite-enter name)
  (begin
    (indented-outln (string-append "enter " name "\n"))
    (push-suite-name name)
  ))

(define (suite-leave)
  (indented-outln (string-append "leave " (pop-suite-name) "\n")))
  
;(define (suite name thunk)
;  (begin
;    (suite-enter name)
;    (thunk)
;    (suite-leave name)
;  ))
