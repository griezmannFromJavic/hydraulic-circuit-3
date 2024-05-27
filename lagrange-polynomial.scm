(define (basis-factor point other-point) ; returns function of x
	(lambda (x) (/ (- x (car other-point)) (- (car point) (car other-point))))
	)
	
(define (list-of-factors point points) ; returns list of functions of x
	(map (lambda (p) (basis-factor point p)) (remove (lambda (p) (equal? point p)) points))
	)

(define (basis-polynomial point points) ; returns function of x
	(multiply-list-of-functions (list-of-factors point points))
	)

(define (lagrange-interpolation points)	; returns function of x
	(sum-list-of-functions
		(map multiply-function-with-number
			(map cadr points) (map (lambda (p) (basis-polynomial p points)) points)))
	)

;; add error message if 2 x's are the same

; EXAMPLE USAGE:
;(define points '((1 10) (2 2) (3 3) (4 7) (6 5) (10 1)))
;(define xs (list 0 1 2 3 4 5 6 7 8 9))
;(map (lagrange-interpolation points) xs)

(define (basis-factor-derivation point other-point)
	(/ (- (cadr other-point) (cadr point)) (car other-point) (car point))
	)

(define (product-rule functions derivatives)
	(sum-list-of-functions
		(multiply-function-with-number (car derivaitves) (multiply-list-of-functions (cdr functions)))
		(multiply-function-with-number (product-rule (cdr functions)) (car functions))
		))
		
(product-rule (list (lambda (x) x) (lambda (x) (+ x x))) (list 1 2))
