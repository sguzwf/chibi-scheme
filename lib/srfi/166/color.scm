;; color.scm -- colored output
;; Copyright (c) 2006-2020 Alex Shinn.  All rights reserved.
;; BSD-style license: http://synthcode.com/license.txt

(define (color->ansi x)
  (case x
    ((bold) "1")
    ((dark) "2")
    ((italic) "3")
    ((underline) "4")
    ((black) "30")
    ((red) "31")
    ((green) "32")
    ((yellow) "33")
    ((blue) "34")
    ((magenta) "35")
    ((cyan) "36")
    ((white) "37")
    ((reset) "39")
    ((on-black) "40")
    ((on-red) "41")
    ((on-green) "42")
    ((on-yellow) "43")
    ((on-blue) "44")
    ((on-magenta) "45")
    ((on-cyan) "46")
    ((on-white) "47")
    ((on-reset) "49")
    (else "0")))

(define (ansi-escape color)
  (if (string? color)
      color
      (string-append "\x1B;[" (color->ansi color) "m")))

(define (colored new-color . args)
  (fn ((orig-color color))
    (with ((color new-color))
      (each (ansi-escape new-color)
            (each-in-list args)
            (if (or (memq new-color '(bold underline))
                    (memq orig-color '(bold underline)))
                (ansi-escape 'reset)
                nothing)
            (ansi-escape orig-color)))))

(define (as-red . args) (colored 'red (each-in-list args)))
(define (as-blue . args) (colored 'blue (each-in-list args)))
(define (as-green . args) (colored 'green (each-in-list args)))
(define (as-cyan . args) (colored 'cyan (each-in-list args)))
(define (as-yellow . args) (colored 'yellow (each-in-list args)))
(define (as-magenta . args) (colored 'magenta (each-in-list args)))
(define (as-white . args) (colored 'white (each-in-list args)))
(define (as-black . args) (colored 'black (each-in-list args)))
(define (as-bold . args) (colored 'bold (each-in-list args)))
(define (as-italic . args) (colored 'italic (each-in-list args)))
(define (as-underline . args) (colored 'underline (each-in-list args)))

(define (on-red . args) (colored 'on-red (each-in-list args)))
(define (on-blue . args) (colored 'on-blue (each-in-list args)))
(define (on-green . args) (colored 'on-green (each-in-list args)))
(define (on-cyan . args) (colored 'on-cyan (each-in-list args)))
(define (on-yellow . args) (colored 'on-yellow (each-in-list args)))
(define (on-magenta . args) (colored 'on-magenta (each-in-list args)))
(define (on-white . args) (colored 'on-white (each-in-list args)))
(define (on-black . args) (colored 'on-black (each-in-list args)))

(define (rgb-escape red-level green-level blue-level bg?)
  (when (not (and (exact-integer? red-level) (<= 0 red-level 5)))
    (error "invalid red-level value" red-level))
  (when (not (and (exact-integer? green-level) (<= 0 green-level 5)))
    (error "invalid green-level value" green-level))
  (when (not (and (exact-integer? blue-level) (<= 0 blue-level 5)))
    (error "invalid blue-level value" blue-level))
  (string-append
   (if bg? "\x1B;[48;5;" "\x1B;[38;5;")
   (number->string (+ (* 36 red-level) (* 6 green-level) blue-level 16))
   "m"))

(define (rgb24-escape red-level green-level blue-level bg?)
  (when (not (and (exact-integer? red-level) (<= 0 red-level 255)))
    (error "invalid red-level value" red-level))
  (when (not (and (exact-integer? green-level) (<= 0 green-level 255)))
    (error "invalid green-level value" green-level))
  (when (not (and (exact-integer? blue-level) (<= 0 blue-level 255)))
    (error "invalid blue-level value" blue-level))
  (string-append
   (if bg? "\x1B;[48;2;" "\x1B;[38;2;")
   (number->string red-level) ";"
   (number->string green-level) ";"
   (number->string blue-level)
   "m"))

(define (as-color red green blue . fmt)
  (colored (rgb-escape red green blue #f) (each-in-list fmt)))

(define (as-true-color red green blue . fmt)
  (colored (rgb24-escape red green blue #f) (each-in-list fmt)))

(define (on-color red green blue . fmt)
  (colored (rgb-escape red green blue #t) (each-in-list fmt)))

(define (on-true-color red green blue . fmt)
  (colored (rgb24-escape red green blue #t) (each-in-list fmt)))
