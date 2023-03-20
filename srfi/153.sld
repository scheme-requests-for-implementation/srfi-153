;; Copyright (C) Marc Nieper-Wißkirchen (2017).  All Rights
;; Reserved.

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

(define-library (srfi 153)
  (export oset oset-unfold
	  oset? oset-contains? oset-empty? oset-disjoint?
	  oset-member oset-element-comparator
	  oset-adjoin oset-adjoin/replace oset-delete oset-delete-all oset-pop
          oset-pop/reverse
	  oset-size oset-find oset-count oset-any? oset-every?
	  oset-map oset-for-each oset-fold oset-fold/reverse
	  oset-filter oset-remove oset-partition
	  oset->list list->oset
	  oset=? oset<? oset>? oset<=? oset>=?
	  oset-union oset-intersection oset-difference oset-xor
          oset-min-element oset-max-element
          oset-element-predecessor oset-element-successor
          oset-range= oset-range< oset-range> oset-range<= oset-range>=
          oset-split oset-catenate)

;; Specialized obag functions (not implemented)
;	  obag-sum obag-product
;	  obag-unique-size obag-element-count obag-for-each-unique obag-fold-unique
  (import (scheme base)
	  (scheme case-lambda)
	  (scheme char)
          (srfi 128)
	  (srfi 146))
  (include "153-impl.scm"))
