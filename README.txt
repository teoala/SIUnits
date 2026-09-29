Progetto E4p - Common Lisp

Innanzitutto i prefissi e le unità si (base o derivate) sono trattate in
maniera case sensitive. Per ottenere dei simboli che rispettino la case
sensitivity, viene usata la notazione |..| oppure la funzione make-symbol a cui
viene passata una stringa. In generale, le funzioni che hanno a che fare coi
simboli possono trattare un simbolo in maniera diversa, per esempio make-symbol
"m" -> \m ma "Sv" -> #:|Sv|. Per questo, quando bisogna confrontare due simboli
non basta usare equal o eql, ma bisogna prima convertire i simboli a stringhe
con string.
É stato scelto di trattare così i prefissi e le unità per rimuovere ambiguità
(s corrisponde a secondi e Siemens in base alla maiuscola, m e M sono prefissi
diversi).
Quando è necessario passare un simbolo come parametro, è necessario
usare le maiuscole in maniera corretta e usare la notazione |..|.

Una eccezione è si-unit-symbol che usa i nomi delle unità di misura in maniera
non case sensitive (per passare parametri basta quindi usare il ').

Per ulteriori informazioni sulle singole funzioni, sono presenti commenti prima
(o all'interno) della funzione stessa.

All'interno del programma l'unità kg ha subito un trattamento particolare,
dovuto al fatto che l'unità base non è quella senza prefisso. Ci sono alcune
funzioni che convertono kg in g e altre che invece g in kg. Le funzioni
"esposte" (quelle richieste dal progetto) convertono alla fine in kg
es. g -> (expt |kg| -3) kg -> (expt |kg| 1)

riguardo la norm, essa non tiene conto dei prefissi es. (* '|cm| '|m|) contano
entrambe come metri. e' rilevante quando, oltre a normalizzare, bisogna
stabilire il valore numerico della quantita'. In quel caso, norm non e' adatta,
bisogna usare norm-total-mult (o, al massimo, norm-mults) che tengono conto dell
esponente di dieci necessario per far corrispondere il numero della quantita' ad
eventuali cambiamenti dei prefissi delle unita' avvenite durante la
normalizzazione.
es. (norm '(* |mm| |m|) -> (* (EXPT #:\m 2))
(norm-total-mult '(* |mm| |m|)) -> (* (expt #:\m 2)) . -3)
perche' 2 mm * m -> 2 * 10^-3 m^2
