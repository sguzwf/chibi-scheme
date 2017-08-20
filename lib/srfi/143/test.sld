(define-library (srfi 143 test)
  (import (scheme base) (srfi 143) (chibi test))
  (export run-tests)
  (begin
    (define (run-tests)
      (test-group "fixnum"
        (test-group "arithmetic"
          (test #t (fixnum? 32767))
          (test #f (fixnum? 1.1))

          (test #t (fx=? 1 1 1))
          (test #f (fx=? 1 2 2))
          (test #f (fx=? 1 1 2))
          (test #f (fx=? 1 2 3))

          (test #t (fx<? 1 2 3))
          (test #f (fx<? 1 1 2))
          (test #t (fx>? 3 2 1))
          (test #f (fx>? 2 1 1))
          (test #t (fx<=? 1 1 2))
          (test #f (fx<=? 1 2 1))
          (test #t (fx>=? 2 1 1))
          (test #f (fx>=? 1 2 1))
          (test '(#t #f) (list (fx<=? 1 1 2) (fx<=? 2 1 3)))

          (test #t (fxzero? 0))
          (test #f (fxzero? 1))

          (test #f (fxpositive? 0))
          (test #t (fxpositive? 1))
          (test #f (fxpositive? -1))

          (test #f (fxnegative? 0))
          (test #f (fxnegative? 1))
          (test #t (fxnegative? -1))

          (test #f (fxodd? 0))
          (test #t (fxodd? 1))
          (test #t (fxodd? -1))
          (test #f (fxodd? 102))

          (test #t (fxeven? 0))
          (test #f (fxeven? 1))
          (test #t (fxeven? -2))
          (test #t (fxeven? 102))

          (test 4 (fxmax 3 4))
          (test 5 (fxmax 3 5 4))
          (test 3 (fxmin 3 4))
          (test 3 (fxmin 3 5 4))

          (test 7 (fx+ 3 4))
          (test 12 (fx* 4 3))

          (test -1 (fx- 3 4))
          (test -3 (fxneg 3))

          (test 7 (fxabs -7))
          (test 7 (fxabs 7))

          (test 1764 (fxsquare 42))
          (test 4 (fxsquare 2))

          (test 2 (fxquotient 5 2))
          (test -2 (fxquotient -5 2))
          (test -2 (fxquotient 5 -2))
          (test 2 (fxquotient -5 -2))

          (test 1 (fxremainder 13 4))
          (test -1 (fxremainder -13 4))
          (test 1 (fxremainder 13 -4))
          (test -1 (fxremainder -13 -4))

          (call-with-values (lambda () (fxsqrt 32))
            (lambda (root rem)
              (test 35 (* root rem)))))

        (test-group "bitwise"
          (test -1 (fxnot 0))
          (test 0 (fxand #b0 #b1))
          (test 6 (fxand 14 6))
          (test 14 (fxior 10 12))
          (test 6 (fxxor 10 12))
          (test 0 (fxnot -1))
          (test 9 (fxif 3 1 8))
          (test 0 (fxif 3 8 1))
          (test 2 (fxbit-count 12))
          (test 0 (fxlength 0))
          (test 8 (fxlength 128))
          (test 8 (fxlength 255))
          (test 9 (fxlength 256))
          (test -1 (fxfirst-set-bit 0))
          (test 0 (fxfirst-set-bit 1))
          (test 0 (fxfirst-set-bit 3))
          (test 2 (fxfirst-set-bit 4))
          (test 1 (fxfirst-set-bit 6))
          (test 0 (fxfirst-set-bit -1))
          (test 1 (fxfirst-set-bit -2))
          (test 0 (fxfirst-set-bit -3))
          (test 2 (fxfirst-set-bit -4))
          (test #t (fxbit-set? 0 1))
          (test #f (fxbit-set? 1 1))
          (test #f (fxbit-set? 1 8))
          (test #t (fxbit-set? 10000 -1))
          (test #t (fxbit-set? 1000 -1))
          (test 0 (fxcopy-bit 0 0 #f))
          (test -1 (fxcopy-bit 0 -1 #t))
          (test 1 (fxcopy-bit 0 0 #t))
          (test #x106 (fxcopy-bit 8 6 #t))
          (test 6 (fxcopy-bit 8 6 #f))
          (test -2 (fxcopy-bit 0 -1 #f))
          (test 0 (fxbit-field 6 0 1))
          (test 3 (fxbit-field 6 1 3))
          (test 2 (fxarithmetic-shift 1 1))
          (test 0 (fxarithmetic-shift 1 -1))
          (test #b110  (fxbit-field-rotate #b110 1 1 2))
          (test #b1010 (fxbit-field-rotate #b110 1 2 4))
          (test #b1011 (fxbit-field-rotate #b0111 -1 1 4))
          (test #b110 (fxbit-field-rotate #b110 0 0 10))
          (test 6 (fxbit-field-reverse 6 1 3))
          (test 12 (fxbit-field-reverse 6 1 4))
          (test -11 (fxnot 10))
          (test 36 (fxnot -37))
          (test 11 (fxior 3  10))
          (test 10 (fxand 11 26))
          (test 9 (fxxor 3 10))
          (test 4 (fxand 37 12))
          (test 32 (fxarithmetic-shift 8 2))
          (test 4 (fxarithmetic-shift 4 0))
          (test 4 (fxarithmetic-shift 8 -1))
          (test 0 (fxlength  0))
          (test 1 (fxlength  1))
          (test 0 (fxlength -1))
          (test 3 (fxlength  7))
          (test 3 (fxlength -7))
          (test 4 (fxlength  8))
          (test 3 (fxlength -8))
          (test #t (fxbit-set? 3 10))
          (test #t (fxbit-set? 2 6))
          (test #f (fxbit-set? 0 6))
          (test #b100 (fxcopy-bit 2 0 #t))
          (test #b1011 (fxcopy-bit 2 #b1111 #f))
          (test 1 (fxfirst-set-bit 2))
          (test 3 (fxfirst-set-bit 40))
          (test 2 (fxfirst-set-bit -28))
          (test 1 (fxand #b1 #b1))
          (test 0 (fxand #b1 #b10))
          (test #b10 (fxand #b11 #b10))
          (test #b101 (fxand #b101 #b111))
          (test #b111 (fxand -1 #b111))
          (test #b110 (fxand -2 #b111))
          (test 1 (fxarithmetic-shift 1 0))
          (test 4 (fxarithmetic-shift 1 2))
          (test 8 (fxarithmetic-shift 1 3))
          (test 16 (fxarithmetic-shift 1 4))
          (test -1 (fxarithmetic-shift -1 0))
          (test -2 (fxarithmetic-shift -1 1))
          (test -4 (fxarithmetic-shift -1 2))
          (test -8 (fxarithmetic-shift -1 3))
          (test -16 (fxarithmetic-shift -1 4))
          (test #b1010 (fxbit-field #b1101101010 0 4))
          (test #b101101 (fxbit-field #b1101101010 3 9))
          (test #b10110 (fxbit-field #b1101101010 4 9))
          (test #b110110 (fxbit-field #b1101101010 4 10))
          (test 3 (fxif 1 1 2))
          (test #b00110011 (fxif #b00111100 #b11110000 #b00001111))
          (test #b1 (fxcopy-bit 0 0 #t)))))))