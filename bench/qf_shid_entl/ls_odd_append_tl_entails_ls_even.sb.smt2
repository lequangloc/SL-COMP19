(set-logic QF_SHID)
(set-info :source | Songbird - https://songbird-prover.github.io/ |)
(set-info :smt-lib-version 2)
(set-info :category "crafted")
(set-info :status unsat)

;; singleton heap

(declare-sort Refnode 0)

(declare-datatypes
 ((node 0))
 (((c_node (next Refnode)))))

(declare-heap (Refnode node))

;; heap predicates

(define-funs-rec (
	(ls ((x_1 Refnode) (y_2 Refnode)) Bool)
	(leven ((x_4 Refnode) (y_5 Refnode)) Bool)
	(lodd ((x_7 Refnode) (y_8 Refnode)) Bool)
		)
		(
  (or
   (and
    (_ emp Refnode node)
    (= x_1 y_2))
   (exists
    ((u_3 Refnode))
    (sep
     (pto x_1 (c_node u_3))
     (ls u_3 y_2))))

;; heap predicates

  (or
   (and
    (_ emp Refnode node)
    (= x_4 y_5))
   (exists
    ((u_6 Refnode))
    (sep
     (pto x_4 (c_node u_6))
     (lodd u_6 y_5))))

;; heap predicates

  (or
   (pto x_7 (c_node y_8))
   (exists
    ((u_9 Refnode))
    (sep
     (pto x_7 (c_node u_9))
     (leven u_9 y_8))))
     		)
)

(check-sat)

;; entailment: z->node{t} * lodd(x,z) |- leven(x,t)

(declare-const z Refnode)
(declare-const t Refnode)
(declare-const x Refnode)

(assert
 (sep
  (pto z (c_node t))
  (lodd x z)))

(assert
 (not
  (leven x t)))

(check-sat)
