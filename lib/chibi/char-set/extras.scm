
(define (char-set . args)
  (list->char-set args))

(define (ucs-range->char-set start end . o)
  (let ((res (make-iset start (- end 1))))
    (if (and (pair? o) (pair? (cdr o)))
        (iset-union res (cadr o))
        res)))

(define char-set-copy iset-copy)

(define char-set-size iset-size)

(define (char-set-fold kons knil cset)
  (iset-fold (lambda (i acc) (kons (integer->char i) acc)) knil cset))

(define (char-set-for-each proc cset)
  (iset-for-each (lambda (i) (proc (integer->char i))) cset))

(define (list->char-set ls . o)
  (apply list->iset (map char->integer ls) o))
(define (char-set->list cset)
  (map integer->char (iset->list cset)))

(define (string->char-set str)
  (list->char-set (string->list str)))
(define (char-set->string cset)
  (list->string (char-set->list cset)))

(define (char-set-adjoin! cset . o)
  (apply iset-adjoin! cset (map char->integer o)))
(define (char-set-adjoin cset . o)
  (apply iset-adjoin cset (map char->integer o)))

(define char-set-union iset-union)
(define char-set-union! iset-union!)
(define char-set-intersection iset-intersection)
(define char-set-intersection! iset-intersection!)
(define char-set-difference iset-difference)
(define char-set-difference! iset-difference!)

(define char-set:empty (immutable-char-set (%make-iset 0 0 0 #f #f)))
(define char-set:ascii (immutable-char-set (%make-iset 0 #x7F #f #f #f)))

(cond-expand
 (full-unicode
  (define char-set:full
    (immutable-char-set
     (%make-iset 0 #xD7FF #f #f (%make-iset #xE000 #x10FFFD #f #f #f)))))
 (else
  (define char-set:full (immutable-char-set (%make-iset 0 #xFF #f #f #f)))))

(define (char-set-complement cset)
  (char-set-difference char-set:full cset))
