;;;; 899988 Alari Matteo
;;;; 909567 Caronni Andrea
;;;; 914295 Trabattoni Sara

; Definizione unita' si derivate e le loro espansioni

(defparameter si-units-exp
  '((|Bq| . (* (expt |s| -1)))
    (|DC| . (* |K|))
    (|C| . (* |s| |A|))
    (|F| . (* (expt |kg| -1) (expt |m| -2) (expt |s| 4) (expt |A| 2)))
    (|Gy| . (* (expt |m| 2) (expt |s| -2)))
    (|Hz| . (* (expt |s| -1)))
    (|H| . (* |kg| (expt |m| 2) (expt |s| -2) (expt |A| -2)))
    (|J| . (* |kg| (expt |m| 2) (expt |s| -2)))
    (|kat| . (* |mol| (expt |s| -1)))
    (|lm| . (* |cd|))
    (|lx| . (* |cd| (expt |m| -2)))
    (|N| . (* |kg| |m| (expt |s| -2)))
    (|omega| . (* |kg| (expt |m| 2) (expt |s| -3) (expt |A| -2)))
    (|Pa| . (* |kg| (expt |m| -1) (expt |s| -2)))
    (|rad| . (* ))
    (|S| . (* (expt |kg| -1) (expt |m| -2) (expt |s| 3) (expt |A| 2)))
    (|Sv| . (* (expt |m| 2) (expt |s| -2)))
    (|sr| . (* ))
    (|T| . (* |kg| (expt |s| -2) (expt |A| -1)))
    (|V| . (* |kg| (expt |m| 2) (expt |s| -3) (expt |A| -1)))
    (|W| . (* |kg| (expt |m| 2) (expt |s| -3)))
    (|Wb| . (* |kg| (expt |m| 2) (expt |s| -2) (expt |A| -1)))
    ))

(defparameter base-si-units '(|kg| |m| |s| |A| |K| |cd| |mol|))

;lista di cons-cell simbolo-nome per tutte le unita base e derivate.
(defparameter units-symbol-name
  '((|kg| . kilogram)
    (|m| . metre)
    (|s| . second)
    (|A| . Ampere)
    (|K| . Kelvin)
    (|cd| . candela)
    (|mol| . mole)
    (|Bq| . Becquerel)
    (|DC| . degreecelsius)
    (|C| . Coulomb)
    (|F| . Farad)
    (|Gy| . Gray)
    (|Hz| . Hertz)
    (|H| . Henry)
    (|J| . Joule)
    (|kat| . Katal)
    (|lm| . lumen)
    (|lx|. lux)
    (|N| . Newton)
    (|omega| . Ohm)
    (|Pa| . Pascal)
    (|rad| . radian)
    (|S| . Siemens)
    (|Sv| . Sievert)
    (|sr| . steradian)
    (|T| . Tesla)
    (|V| . Volt)
    (|W| . Watt)
    (|Wb| . Weber)
    )
  )

;stabilisce l'ordine delle unita'.
(defparameter units-symbol-order
    '((|kg| . 1)
    (|m| . 2)
    (|s| . 3)
    (|A| . 4)
    (|K| . 5)
    (|cd| . 6)
    (|mol| . 7)
    (|Bq| . 8)
    (|DC| . 9)
    (|C| . 10)
    (|F| . 11)
    (|Gy| . 12)
    (|Hz| . 13)
    (|H| . 14)
    (|J| . 15)
    (|kat| . 16)
    (|lm| . 17)
    (|lx|. 18)
    (|N| . 19)
    (|omega| . 20)
    (|Pa| . 21)
    (|rad| . 22)
    (|S| . 23)
    (|Sv| . 24)
    (|sr| . 25)
    (|T| . 26)
    (|V| . 27)
    (|W| . 28)
    (|Wb| . 29)
    )
  )

;lista di tutte le unita si come stringhe (i simboli) in minuscolo
;con kg.

(defparameter units-symbol-string-withkg
  (mapcar 'string-downcase (mapcar 'string (mapcar 'car units-symbol-name))))

;lista di coppie simbolo prefisso - valore
;NB il simbolo di micro e' uguale al suo nome
(defparameter si-prefixes
 '((|Q| . (expt 10 30))
   (|R| . (expt 10 27))
   (|Y| . (expt 10 24))
   (|Z| . (expt 10 21))
   (|E| . (expt 10 18))
   (|P| . (expt 10 15))
   (|T| . (expt 10 12))
   (|G| . (expt 10 9))
   (|M| . (expt 10 6))
   (|k| . (expt 10 3))
   (|h| . (expt 10 2))
   (|da| .(expt 10 1))
   (|d| . (expt 10 -1))
   (|c| . (expt 10 -2))
   (|m| . (expt 10 -3))
   (|micro| . (expt 10 -6))
   (|n| . (expt 10 -9))
   (|p| . (expt 10 -12))
   (|f| . (expt 10 -15))
   (|a| . (expt 10 -18))
   (|z| . (expt 10 -21))
   (|y| . (expt 10 -24))
   (|r| . (expt 10 -27))
   (|q| . (expt 10 -30))))




;data una unita' SI per nome, restituisce la lista con tutti i
;possibili multipli di quell'unita' come simboli.
;NB questa funzione NON VA BENE PER I KG.
(defun make-unit-prefixes (unit)
  (mapcar 'make-symbol
	  (mapcar
	   (lambda (x)(concatenate 'string x
				    (string (si-unit-symbol unit))))
	   (mapcar 'string (mapcar 'car si-prefixes)))))

;dato un simbolo, restituisce la lista con tutti i prefissi applicati al
;simbolo. Da usare con g (grammo).
(defun make-symbol-prefixes (symb)
    (mapcar 'make-symbol
	  (mapcar
	   (lambda (x)(concatenate 'string x
				    (string symb)))
	   (mapcar 'string (mapcar 'car si-prefixes)))))

;ritorna T se il suo argomento e' un simbolo (la sigla) delle unita' di base
;e' case sensitive. non accetta i multipli delle unita'.
;da wikipedia: "The grouping formed by a prefix symbol attached to a unit symbol
;(e.g. 'km', 'cm') constitutes a new inseparable unit symbol."
;allora i multipli non sono unita' di base.

(defun is-base-si-unit (unit)
  (not
   (null (find-if
	  (lambda (x)
	    (equal x (string unit)))
	  (mapcar 'string base-si-units)))))

;ritorna T se il suo argomento e' un simbolo che denota una unita SI base o
;derivata. Non accetta i multipli delle unita'.

(defun is-si-unit (unit)
  (or
   (is-base-si-unit unit)
   (not
    (null (find-if (lambda (x) (equal x (string unit)))
		(mapcar (lambda (x) (string (car x))) units-symbol-name))))))

;ritorna il nome del simbolo passato come argomento, altrimenti NIL
;Non accetta i multipli delle unita'.
(defun si-unit-name (unit &optional (i 0))
  (cond
   ((null (nth i units-symbol-name)) NIL)
   ((equal (string unit)
	   (string(car (nth i units-symbol-name))))
    (cdr (nth i units-symbol-name)))
   (T (si-unit-name unit (+ i 1)))))

;ritorna il simbolo del nome (formato simbolo, non case sensitive)
;di una unita SI passata come argomento, altrimenti
;NIL. Non accetta i multipli delle unita'.

(defun si-unit-symbol (unit &optional (i 0))
  (cond
   ((null (nth i units-symbol-name)) NIL)
   ((equal unit
	   (cdr (nth i units-symbol-name)))
    (car (nth i units-symbol-name)))
   (T (si-unit-symbol unit (+ i 1))))
  )


;ritorna l'espansione in forma canonica dell'unita' derivata unit. 

(defun si-unit-base-expansion (unit)
  (let ((si-unit
	 (if (is-si-unit unit)
	     unit (make-symbol (check-prefixed-si-unit unit)))))
    (rest
     (find-if (lambda (x)
		(equal (string si-unit) (string (first x))))
	      si-units-exp))))



;confronta due unita' (della stessa unita' base, per esempio |mm| e |km|.
;restituisce <, > o = in base all'esito del confronto.
;es |mm| |Mm| -> <

(defun compare-units (u1 u2)
  (let ((du1 (decompose-si-unit u1)) (du2 (decompose-si-unit u2)))
    (if (and (not (null du1)) (not (null du2)))
	(let ((dubase1 (if (listp du1) (first du1) du1))
	      (dubase2 (if (listp du2) (first du2) du2)))
	  (if (equal (conv-to-string dubase1)
		     (conv-to-string dubase2))
	    (let ((val (- (if (listp du1) (first (last du1)) 0)
			  (if (listp du2) (first (last du2)) 0))))
	      (cond ((< val 0) '<)
		    ((= val 0) '=)
		    (t '>))))))))

;ritorna T se qt e' una quantita' (q numero dimensione)

(defun is-quantity (q)
  (and (listp q)
       (eq 'q (first q))
       (let ((n (second q))
	     (d (third q))
	     )
	 (and (numberp n)
	      (is-dimension d)))))

;ritorna T se dim e' una dimensione, ovvero un simbolo di unita' base o derivat
;a oppure una lista con operatore * e operandi unita' o espressioni
;(expt u e)
;NB (expt m 2) non e' valido (da solo), (* (expt m 2 )) si.

(defun is-dimension (dim)
  (cond ((and (not (listp dim))(not (null (decompose-si-unit dim))) t))
	((and (listp dim)) (equal (first dim) '*)
	 (and-list (mapcar 'is-unit-operand
			      (rest dim))))))

;restituisce t se tutti gli elementi di una lista sono T,altrimenti NIL.

(defun and-list (boolist)
  (cond ((null boolist) T)
	(t (and (car boolist) (and-list (rest boolist))))))

;ritorna T se dim e' un unita' SI (multiplo o non) o se e' una espressione
;del tipo (expt u e) con u unita' si (multiplo o non) ed e numero.

(defun is-unit-operand (operand)
  (cond ((listp operand) (and (equal (first operand) 'expt)
			     (not (null (decompose-si-unit (second operand))))
			     (numberp (third operand))))
	((not (null (decompose-si-unit operand))) t)))

;restituisce l'unita' se l argomento e' un unita' base e derivata senza prefisso
;se ha il prefisso restituisce ('unitabase expt 10 val) altrimenti rest NIL.
;NB questa funzione tratta g come l'unita' base per il peso.

(defun decompose-si-unit (dim)
  (cond ((equal dim '|g|) dim)
	((is-si-unit dim) dim)
	((not (null (check-prefixed-si-unit dim)))
	(cons (make-symbol (check-prefixed-si-unit dim))
	      (rest (car
		     (decompose-prefixed-si-unit dim
					    (check-prefixed-si-unit dim))))))))

;restituisce simbolo del prefisso e potenza di dieci dato argomento unita'
;con prefisso e unita' corrispondente senza prefisso.
;NB decompone kg in g * 10 exp 3

(defun decompose-prefixed-si-unit (prefixed base)
  (remove-if-not (lambda (x)
	       ;cerca il prefisso
		   (and (not (null x))
			(equal (string (car x))
		      (subseq (string prefixed) 0
			      (min (length (string prefixed))
				   (length (string (car x))))))
	       ;assicurati che dopo il prefisso ci sia l'unita'
		    (equal (string base)
			   (subseq
			    (string prefixed)
			    (min (length (string prefixed))
				  (length (string (car x))))))))
	     si-prefixes))

;ritorna l'unita senza prefisso come stringa se l'argomento e' un unita'
;con prefisso altrimenti NIL.
;restituisce NIL se l'unita' passata non ha prefisso.
;NB se l'argomento e' kg restituisce g.

(defun check-prefixed-si-unit (dim)
  (first (remove-if
	  (lambda (x)
	    (null (find-if
		   (lambda (y) (equal y (string dim)))
		   (mapcar 'string (if (equal x "g")
				      (make-symbol-prefixes (make-symbol x))
				      (make-unit-prefixes
				       (si-unit-name
					(make-symbol x))))))))
	   (find-units-list (string dim)))))

;ritorna una lista contenente tutti i simboli unita si senza prefissi
;che compaiono nella stringa argomento
;nb al posto di kg cerca g

(defun find-units-list (dim)
  (remove-if (lambda (x) (null(search x dim)))
	     ;sostituisci kg con g
	     (substitute-if "g" (lambda (x) (equal x "kg"))
			    (mapcar 'string
				    (mapcar 'car units-symbol-name)))))

; Normalizzazione delle dimensioni
;ovvero restituisce la forma canonica della dimensione passata come argomento.
;per arrivare alla forma canonica, fa il prodotto di tutte le unita' dello 
;stesso tipo, rimuove le unita' elevate alla zero e le ordina.
;NB norm tratta unita che differiscono solo per il prefisso come se
;fossero uguali es. (* (expt |cm| 1) (expt |m| 1)) diventa (* (expt |m| 2))

(defun norm (dim)
  ;se dim e' un unita' con o senza prefisso restituisce (* dim)
  (cond ((and (not (listp dim)) (equal (string dim) "g")) (list '* '|g|))
	((and
	  (not (listp dim))
	  (or (is-si-unit dim)
	      (not (null (check-prefixed-si-unit dim)))))
	 (list '* (first (expt-base-unit dim))))
	 ((and (listp dim) (equal '* (first dim))
	       (cons '*
		     (simplify-base-units-list (sort (mapcar 'first
			     (sum-base-units
			      (mapcar 'expt-base-unit
				      (rest dim))))
					'<= :key 'symbol-order-value )))))))

;ha il comportamento di norm ma tiene conto dell'esponente con base 10
;corrispondente ai prefissi ((expt u e) esponentebase10)

(defun norm-mults (dim)
  ;se dim e' un unita' con o senza prefisso restituisce (* dim)
  (cond ((and (not (listp dim))(equal (string dim) "g")) (list '* (expt-base-unit '|g|)))
    ((and
	  (not (listp dim))
	  (or (is-si-unit dim)
	      (not (null (check-prefixed-si-unit dim)))))
	 (list '* (expt-base-unit dim)))
	 ((and (listp dim) (equal '* (first dim))
	       (cons '*
		     (simplify-base-units-list-mults (sort
			     (sum-base-units
			      (mapcar 'expt-base-unit
				      (rest dim)))
					'<= :key (lambda (x) (symbol-order-value
							      (first x))))))))))
;ha il comportamento di norm e rest. ((* /unita normalizzate/) . esponente
;corrispondente ai prefissi)

(defun norm-total-mult (dim)
  (let ((norm-dim (rest (norm-mults dim))))
    (cons (cons '* (mapcar 'first norm-dim)) (reduce '+ (mapcar 'second norm-dim)))))

;prende come argomento un simbolo di unita' si e restituisce il suo valore
;d'ordine, NIL altrimenti.

(defun symbol-order-value (sym)
  (rest (find-if (lambda (x) (equal (string(first x)) (string (second sym)))) units-symbol-order)))

;prende come argomento una lista di (expt u e) e restituisce una lista con
;alcune modiche. per ogni elemento della lista, se e = 1, sostituisci con
;solo l'unita', se e = 0, rimuovi.

(defun simplify-base-units-list (ls)
  (mapcar
   (lambda (x)
     (cond ((equal 1 (third x)) (second x)) (t x)))
   (remove-if (lambda (x) (equal 0 (third x))) ls)))

;funzione simile a simplify-base-units-list ma compatibile con norm-mults.

(defun simplify-base-units-list-mults (ls)
   (remove-if (lambda (x) (equal 0 (third (first x)))) ls))

;prende come argomento una lista di ((expt u e) esp) (ottenuta da fz
;expt-base-unit. Prende tutte gli elementi corrispondenti ad un unita si e
;calcola il prodotto. es. ((expt |m| 2) 2) ((expt |m| 1) 2) diventa
;((expt |m| 3) 4)

(defun sum-base-units (ls)
  (let ((base-units
	 (remove-duplicates (mapcar (lambda (x) (second (first x))) ls)
			    :test (lambda (x y)
				    (equal (string x) (string y))))))
  (mapcar 'sum-same-base-units
	  (mapcar (lambda (x)
		    (remove-if-not
		     (lambda (y)
		       (equal (string x) (string (second (first y)))))
		     ls))
	  base-units))))

;prende come argomento una lista di ((expt u e) esp) e da per scontato che siano
;tutte della stessa unita'.
;calcola il prodotto. es. ((expt |m| 2) 2) ((expt |m| 1) 2) diventa
;((expt |m| 3) 4)

(defun sum-same-base-units (ls)
  (if (not (null ls))
      (list (list 'expt (second (first (first ls)))
		  (reduce #'+ (mapcar (lambda (x) (third (first x))) ls)))
			    (reduce #'+ (mapcar (lambda (x) (second x)) ls)))))


;se l'argomento é un unita' base restituisce (expt dim 1)
;se l'argomento é un unita' con prefisso rest. ((expt dim 1) esp) dove esp
;e' l'esponente corrispondente alla potenza di 10 del  prefisso.
;se l'argomento é una lista (expt u e) restituisce
;((expt u1 e) num) dove u1 e' l' unita senza prefisso corrispondente a u
;e num e' l esponente di dieci per fare la conversione tra unita' mantenendo la
;quantita' equivalente es. (expt cm 1) diventa ((expt m 1) -2)
;per calcolare num bisogna moltiplicare e per l'esponente corrispondente al
;prefisso es (expt |cm| 3) diventa ((expt |m| 3) -6) ovvero -2 * 3.

(defun expt-base-unit (dim)
  (cond
    ;caso particolare (expt ?g num)
    ((and (listp dim) (equal (first dim) 'expt) (numberp (third dim))
	  (or (equal "g" (string (second dim)))
	      (if (is-si-unit (second dim))
		  (equal "g" (string
			      (check-prefixed-si-unit
			       (second dim)))))))
     (equal "g" (string (second dim)))
      (list (list 'expt '|kg| (third dim))
	    (* (third dim) (+ -3 (if (null (decompose-prefixed-si-unit
					    (second dim) '|g|))
				     0
				     (car
				      (last (first (decompose-prefixed-si-unit
						    (second dim) '|g|)))))))))
    ;caso (expt u e)
    ((listp dim) (let ((ex (first dim)) (u (second dim)) (e (third dim))
		       (ubase
			((lambda (x) (if (is-si-unit x) x
					 (make-symbol (check-prefixed-si-unit
					  x))))
			 (second dim))))
		   (if (and (equal ex 'expt) (numberp e))
		       (cond ((is-si-unit u) (list dim 0))
			     ((not (null ubase))
			      (list (list 'expt ubase e)
				    (* e (car (last
					       (first
						(decompose-prefixed-si-unit
						 u ubase)))))))))))
    ((equal "kg" (string dim)) (list (list 'expt '|kg| 1) 0))
    ((equal "g" (string dim)) (list (list 'expt '|kg| 1) -3))
    
    ((not (null (decompose-prefixed-si-unit dim '|g|)))
     (list (list 'expt '|kg| 1) (+ -3
				   (car (last (first(decompose-prefixed-si-unit
						     dim '|g|)))))))
    ((is-si-unit dim) (list (list 'expt dim 1) 0))
    (t (let ((ubase (make-symbol (check-prefixed-si-unit dim))))
	 (if
	  (not (null ubase))
	  (list (list 'expt ubase 1)
		(car
		 (last
		  (first (decompose-prefixed-si-unit dim ubase))))))))))

; Operazioni tra quantita'. l'unita' e' portata alla forma senza prefissi,
;il valore di N viene sistemato di conseguenza.

;costruttore (q numero dimensione)

(defun q (N D)
  (let ((norm-mult (norm-total-mult D)))
    (list 'q (* N (expt 10 (cdr norm-mult))) (car norm-mult))))

;ritorna T se dim1 e dim2, dimensioni in forma canonica, sono uguali.

(defun same-dim-p (dim1 dim2)
  (equal (mapcar (lambda (x) (if (listp x) (mapcar 'conv-to-string x) (conv-to-string x)))
		 dim1)
	 (mapcar (lambda (x) (if (listp x) (mapcar 'conv-to-string x) (conv-to-string x)))
		 dim2)))

;converte x a stringa.

(defun conv-to-string (x)
  (cond ((numberp x) (write-to-string x))
	(t (string x))))

;somma due quantita' con la stessa dimensione.

(defun qadd (q1 q2)
  (let ((v1 (second q1))
        (d1 (third q1))
        (v2 (second q2))
        (d2 (third q2)))
    (if (same-dim-p d1 d2)
        (q (+ v1 v2) d1)
        (error "Dimensioni incompatibili in qadd"))))

;Sottrae due quantita' con la stessa dimensione.

(defun qsub (q1 q2)
  (let ((v1 (second q1))
        (d1 (third q1))
        (v2 (second q2))
        (d2 (third q2)))
    (if (same-dim-p d1 d2)
        (list (- v1 v2) d1)
        (error "Dimensioni incompatibili in qsub"))))

;moltiplica due quantita', anche con dimensioni diverse.

(defun qmul (q1 q2)
  "Moltiplica due quantitÃ , sommando le dimensioni."
  (let ((v1 (second q1))
        (d1 (third q1))
        (v2 (second q2))
        (d2 (third q2)))
    (q (* v1 v2)
          (append (list '*) (rest d1) (rest d2)))))

;divide due quantita', anche con dimensioni diverse.

(defun qdiv (q1 q2)
  "Divide due quantitÃ , sottraendo le dimensioni."
  (let ((v1 (second q1))
        (d1 (third q1))
        (v2 (second q2))
        (d2 (third q2)))
    (if (not (equal v2 0)) (q (/ v1 v2)
       (append (list '*)
	       (rest d1)
	       (mapcar (lambda (x) (if (listp x) (list (first x) (second x)
						       (* -1 (third x)))))
		       (rest d2))))
	(error "Impossibile dividere per 0"))))

;calcola la potenza di una quantita', con esponente intero positivo.

(defun qexp (q n)
  "Eleva una quantitÃ  a potenza intera n."
  (if (and (plusp n) (typep n 'integer))
      (if (eql n 1) q (qmul q (qexp q (- n 1))))))
