#lang racket

(require 2htdp/batch-io)
(require "../../../main/racket/spreadsheet/spreadsheet.rkt")
(require "../unit_testing/unit_testing.rkt")
(define-namespace-anchor namespace-anchor)
(define namespace (namespace-anchor->namespace namespace-anchor))

; Dennis Cosgrove

(suite-enter "spreadsheet_tests")

(suite-enter "string->cell")
  (assert-eval-equal? "fred" '(string->cell "fred") namespace)
  (assert-eval-equal? 42 '(string->cell "42") namespace)
  (assert-eval-equal? (void) '(string->cell "") namespace)
(suite-leave)

(define (string->csv s)
  (simulate-file read-csv-file s))

(define nums-csv (string->csv "1,2,3,4\n10,20,30,40"))
(define grades-csv (string->csv "Name,Java List,SML Calendar,SML Hearts,SML Card Game,Java HOF,SML Binary Tree,SML Pattern Matching\nMax,100,104,100,104,100,100,105\nJoshua Bloch,100,85,80,75,100,70,65\nHarry Q. Bovik,80,81,82,83,84,85,86\nDan Grossman,75,104,100,104,80,100,105\nShannon O'Ganns,70,40,0,120,120,130,140"))
(define hockey-csv (string->csv "Name,Uniform Number,Birth Year,Games Played,Goals,Assists\nBobby Orr,4,1948,657,270,645\nWayne Gretzky,99,1961,1487,894,1963\nMario Lemieux,66,1965,915,690,1033"))
(define string-void-number-csv (string->csv "A,,1\nB,,2"))

(define nums-sheet
  '((1 2 3 4)
    (10 20 30 40)))
(define grades-sheet
  '(("Name" "Java List" "SML Calendar" "SML Hearts" "SML Card Game" "Java HOF" "SML Binary Tree" "SML Pattern Matching")
    ("Max" 100 104 100 104 100 100 105)
    ("Joshua Bloch" 100 85 80 75 100 70 65)
    ("Harry Q. Bovik" 80 81 82 83 84 85 86)
    ("Dan Grossman" 75 104 100 104 80 100 105)
    ("Shannon O'Ganns" 70 40 0 120 120 130 140)))
(define hockey-sheet
  '(("Name" "Uniform Number" "Birth Year" "Games Played" "Goals" "Assists")
    ("Bobby Orr" 4 1948 657 270 645)
    ("Wayne Gretzky" 99 1961 1487 894 1963)
    ("Mario Lemieux" 66 1965 915 690 1033)))
(define string-void-number-sheet
  (list (list "A" (void) 1) (list "B" (void) 2)))
 

(suite-enter "csv->spreadsheet")
   (assert-eval-equal? nums-sheet '(csv->spreadsheet nums-csv) namespace)
   (assert-eval-equal? grades-sheet '(csv->spreadsheet grades-csv) namespace)
   (assert-eval-equal? hockey-sheet '(csv->spreadsheet hockey-csv) namespace)
   (assert-eval-equal? string-void-number-sheet '(csv->spreadsheet string-void-number-csv) namespace)
(suite-leave)


(suite-enter "row-count")
   (assert-eval-equal? 2 '(row-count nums-sheet) namespace)
   (assert-eval-equal? 6 '(row-count grades-sheet) namespace)
   (assert-eval-equal? 4 '(row-count hockey-sheet) namespace)
   (assert-eval-equal? 2 '(row-count string-void-number-sheet) namespace)
(suite-leave)

(suite-enter "row-at")
   (assert-eval-equal? '(1 2 3 4) '(row-at nums-sheet 0) namespace)
   (assert-eval-equal? '(10 20 30 40) '(row-at nums-sheet 1) namespace)
   (assert-eval-equal? '("Name" "Java List" "SML Calendar" "SML Hearts" "SML Card Game" "Java HOF" "SML Binary Tree" "SML Pattern Matching") '(row-at grades-sheet 0) namespace)
   (assert-eval-equal? '("Max" 100 104 100 104 100 100 105) '(row-at grades-sheet 1) namespace)
   (assert-eval-equal? '("Joshua Bloch" 100 85 80 75 100 70 65) '(row-at grades-sheet 2) namespace)
   (assert-eval-equal? '("Harry Q. Bovik" 80 81 82 83 84 85 86) '(row-at grades-sheet 3) namespace)
   (assert-eval-equal? '("Dan Grossman" 75 104 100 104 80 100 105) '(row-at grades-sheet 4) namespace)
   (assert-eval-equal? '("Shannon O'Ganns" 70 40 0 120 120 130 140) '(row-at grades-sheet 5) namespace)
   (assert-eval-equal? '("Name" "Uniform Number" "Birth Year" "Games Played" "Goals" "Assists") '(row-at hockey-sheet 0) namespace)
   (assert-eval-equal? '("Bobby Orr" 4 1948 657 270 645) '(row-at hockey-sheet 1) namespace)
   (assert-eval-equal? '("Wayne Gretzky" 99 1961 1487 894 1963) '(row-at hockey-sheet 2) namespace)
   (assert-eval-equal? '("Mario Lemieux" 66 1965 915 690 1033) '(row-at hockey-sheet 3) namespace)
   (assert-eval-equal? (list "A" (void) 1) '(row-at string-void-number-sheet 0) namespace)
   (assert-eval-equal? (list "B" (void) 2) '(row-at string-void-number-sheet 1) namespace)
(suite-leave)

(suite-enter "sum-row")
   (assert-eval-equal? 10 '(sum-row nums-sheet 0) namespace)
   (assert-eval-equal? 100 '(sum-row nums-sheet 1) namespace)
   (assert-eval-equal? 0 '(sum-row grades-sheet 0) namespace)
   (assert-eval-equal? 713 '(sum-row grades-sheet 1) namespace)
   (assert-eval-equal? 575'(sum-row grades-sheet 2) namespace)
   (assert-eval-equal? 581 '(sum-row grades-sheet 3) namespace)
   (assert-eval-equal? 668 '(sum-row grades-sheet 4) namespace)
   (assert-eval-equal? 620 '(sum-row grades-sheet 5) namespace)
   (assert-eval-equal? 0 '(sum-row hockey-sheet 0) namespace)
   (assert-eval-equal? 3524 '(sum-row hockey-sheet 1) namespace)
   (assert-eval-equal? 6404 '(sum-row hockey-sheet 2) namespace)
   (assert-eval-equal? 4669 '(sum-row hockey-sheet 3) namespace)
   (assert-eval-equal? 1 '(sum-row string-void-number-sheet 0) namespace)
   (assert-eval-equal? 2 '(sum-row string-void-number-sheet 1) namespace)
(suite-leave)

(suite-enter "sum-row-functions")
  (define function-csv (string->csv "(+ 1 2),(+ 3 4)\n(/ 10 2),(sqrt (/ 1 4))\n(sin (/ 3.14159 4)),10"))
  (define function-sheet (csv->spreadsheet function-csv))
  (assert-eval-equal? 10 '(sum-row function-sheet 0) namespace)
  (assert-eval-equal? (+ 5 (/ 1 2)) '(sum-row function-sheet 1) namespace)
  (assert-eval-within 10.707106312093558 '(sum-row function-sheet 2) 0.0000001 namespace)
(suite-leave)

(suite-leave)
