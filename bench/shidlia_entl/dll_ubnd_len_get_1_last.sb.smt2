(set-logic SHIDLIA)
(set-info :source | Songbird - https://songbird-prover.github.io/ |)
(set-info :smt-lib-version 2)
(set-info :category "crafted")
(set-info :status unsat)

;; singleton heap

(declare-sort Refnode 0)

(declare-datatypes
 ((node 0))
 (((c_node (next Refnode) (prev Refnode)))))

(declare-heap (Refnode node))

;; heap predicates

(define-fun-rec dll ((hd_1 Refnode) (p_2 Refnode) (tl_3 Refnode) (n_4 Refnode) (len_5 Int)) Bool
  (or
   (and
    (pto hd_1 (c_node n_4 p_2))
    (and
     (= (- len_5 1) 0)
     (= hd_1 tl_3)))
   (exists
    ((x_6 Refnode) (k Int))
    (and
     (sep
      (pto hd_1 (c_node x_6 p_2))
      (dll x_6 hd_1 tl_3 n_4 k))
     (= k (- len_5 1))
     (<= 1 (- len_5 1))))))

(check-sat)

;; entailment: dll(x,y,z,t,n) & 1000<=n |- (exists u. z->node{t,u} * dll(x,y,u,z,n-1))

(declare-const x Refnode)
(declare-const y Refnode)
(declare-const z Refnode)
(declare-const t Refnode)
(declare-const n Int)

(assert
 (and
  (dll x y z t n)
  (<= 1000 n)))

(assert
 (not
  (exists
   ((u Refnode) (k Int))
   (and
   (sep
    (pto z (c_node t u))
    (dll x y u z k)) (= k (+ n (- 1)))))))

(check-sat)
