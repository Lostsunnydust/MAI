``` lisp
(defun one-step(k l m n)
  (cond ((or (= (- k m) (- l n)))t)
        ((or (= (- k m) (- n l)))t)
       ))


(defun two-steps (k l m n)
    (let* (
            (i1 (/ (+ (+ k m) (- n l))2) )
            (j1 (/ (+ (- m k) (+ n l))2) )
            (i2 (/ (+ (+ k m) (- l n))2) )
            (j2 (/ (+ (- k m) (+ n l))2) )
        )

        (if (and (> i1 0 ) (> j1 0 )) (list i1 j1) (list i2 j2))
    )
)

(defun bishop-moves(k l m n)
  (cond
     ((one-step k l m n)t)
     ((/= ( rem (+ k l) 2) (rem (+ m n) 2)) nil)
     (T (values-list (two-steps k l m n)))
))
```
