;;;; Implementation for SRFI 153 atop SRFI 146 (mappings)

(define-record-type <oset>
  (S mapping)   ; S constructs oset
  oset?
  (mapping M))  ; M extracts mapping

(define (list->oset comp elems)
  (S (alist->mapping comp (map (lambda (elem) (cons elem 1)) elems))))

(define (oset comp . elems)
  (list->oset comp elems))

(define (oset-unfold stop? mapper successor seed comp)
  (S (mapping-unfold stop? (lambda (seed) (values (mapper seed) 1))
    successor seed comp)))

(define (oset-unfold/ordered stop? mapper successor seed comp)
  (S (mapping-unfold/ordered stop? (lambda (seed) (values (mapper seed) 1))
    successor seed comp)))

(define (oset-contains? oset elem)
  (mapping-contains? (M oset) elem))

(define (oset-empty? oset)
  (mapping-empty? (M oset)))

(define (oset-disjoint? oset1 oset2)
  (mapping-disjoint? (M oset1) (M oset2)))

(define (oset-member oset elem default)
  (if (oset-contains? oset elem) elem default))

(define (oset-element-comparator oset)
  (mapping-key-comparator (M oset)))

(define (alternate keys value)
  (define (alternate-acc keys result)
    (if (null? keys)
      (reverse result)
      (alternate-acc
         (cdr keys)
         (cons value (cons (car keys) result)))))
  (alternate-acc keys '()))

(define (oset-adjoin oset . elems)
  (S (apply mapping-adjoin (M oset) (alternate elems 1))))

(define (oset-delete oset . elems)
  (oset-delete-all oset elems))

(define (oset-delete-all oset elem-list)
  (S (mapping-delete-all (M oset) elem-list)))

(define failval (list 'failval))

(define oset-pop
  (case-lambda
    ((oset)
       (oset-pop oset (lambda () (error "oset-pop failure"))))
    ((oset fail)
       (let-values (((mapping key value)
                     (mapping-pop 
		       (M oset)
		       (lambda () (values failval failval failval)))))
       (if (eq? key failval)
          (fail)
	  (values (S mapping) key))))))

(define (oset-size oset)
  (mapping-size (M oset)))

(define (oset-find pred oset failure)
  (let-values (((key value)
                (mapping-find
                  (lambda (key value) (pred key))
                  (M oset)
                  (lambda () (values failval failval)))))
    (if (eq? key failval)
      (failure)
      key)))

(define (oset-count pred oset)
  (mapping-count (lambda (key value) (pred key)) (M oset)))

(define (oset-any? pred oset)
  (mapping-any? (lambda (key value) (pred key)) (M oset)))

(define (oset-every? pred oset)
  (mapping-every? (lambda (key value) (pred key)) (M oset)))

(define (oset-map proc comparator oset)
  (S (mapping-map (lambda (key value) (values (proc key) value))
                 comparator (M oset))))

(define (oset-for-each proc oset)
  (mapping-for-each (lambda (key value) (values (proc key) value)) (M oset)))

(define (oset-fold proc nil oset)
  (mapping-fold (lambda (key value acc) (proc key acc)) nil (M oset)))

(define (oset-fold/reverse proc nil oset)
  (mapping-fold/reverse (lambda (key value acc) (proc key acc)) nil (M oset)))

(define (oset-filter pred oset)
  (S (mapping-filter (lambda (key value) (pred key)) (M oset))))

(define (oset-remove pred oset)
  (S (mapping-remove (lambda (key value) (pred key)) (M oset))))

(define (oset-partition pred oset)
  (let-values (((in out)
                (mapping-partition
                  (lambda (key value) (pred key))
                  (M oset))))
    (values (S in) (S out))))

(define (oset->list oset)
  (map car (mapping->alist (M oset))))

(define (oset=? . osets)
  (S (apply mapping=? (map M osets))))

(define (oset<? . osets)
  (S (apply mapping<? (map M osets))))

(define (oset>? . osets)
  (S (apply mapping>? (map M osets))))

(define (oset<=? . osets)
  (S (apply mapping<=? (map M osets))))

(define (oset>=? . osets)
  (S (apply mapping>=? (map M osets))))

(define (oset-union . osets)
  (S (apply mapping-union (map M osets))))

(define (oset-intersection . osets)
  (S (apply mapping-intersection (map M osets))))

(define (oset-difference . osets)
  (S (apply mapping-difference (map M osets))))

(define (oset-xor oset1 oset2)
  (S (mapping-xor (M oset1) (M oset2))))

(define (oset-min-element oset)
  (mapping-min-key (M oset)))

(define (oset-max-element oset)
  (mapping-max-key (M oset)))

(define (oset-element-predecessor oset)
  (mapping-key-predecessor (M oset)))

(define (oset-element-successor oset)
  (mapping-key-successor (M oset)))

(define (oset-range= oset obj)
  (S (mapping-range= (M oset) obj)))

(define (oset-range< oset obj)
  (S (mapping-range< (M oset) obj)))

(define (oset-range> oset obj)
  (S (mapping-range> (M oset) obj)))

(define (oset-range<= oset obj)
  (S (mapping-range<= (M oset) obj)))

(define (oset-range>= oset obj)
  (S (mapping-range>= (M oset) obj)))

(define (oset-split oset obj)
  (S (mapping-split (M oset) obj)))

(define (oset-catenate oset obj)
  (S (mapping-catenate (M oset) obj)))

