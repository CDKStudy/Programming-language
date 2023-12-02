#lang racket
(require 2htdp/image)
(provide (all-defined-out))

; Dekang Cao
(define (snowflake len iter is-flipped)
  (cond [(zero? iter)(line len 0 "blue")]
  [else
  (let* ((prev (snowflake (/ len 4) (- iter 1) is-flipped))(rot-up (rotate 60 prev))(rot-down (rotate 120 prev)))
  (cond [is-flipped
    (beside/align "baseline" prev 
    (beside/align "baseline" (rotate 60 prev)
    (beside/align "baseline" (rotate 120 prev)prev)))]
  [else
    (beside/align "baseline" prev 
    (beside/align "baseline" (rotate 60 prev)
    (flip-horizontal(beside/align "baseline" prev (rotate 60 prev)))))]))])) 
(define (snowflake-symmetric len iter)
  (snowflake len iter #f))
(define (snowflake-flipped len iter)
  (snowflake len iter #t))

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (for-each
   displayln
   (local
     ([define length 400])
     (append
      (for/list ([iter (in-range 5)])
        (snowflake-symmetric length iter))
      (for/list ([iter (in-range 5)])
        (snowflake-flipped length iter))))))
