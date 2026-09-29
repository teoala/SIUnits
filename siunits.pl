%%%% 899988 Alari Matteo
%%%% 914295 Trabattoni Sara
%%%% 909567 Caronni Andrea
    
% UnitÃ  base SI
is_base_si_unit(m).     % metro
is_base_si_unit(kg).    % chilogrammo
is_base_si_unit(s).     % secondo
is_base_si_unit('A').   % ampere
is_base_si_unit('K').   % kelvin
is_base_si_unit(mol).   % mole
is_base_si_unit(cd).    % candela

% Riconoscimento unitÃ  SI (base o derivate). Riconosce anche unita' con
%esponenziale e prodotti di unita'/esponenziali. NON accetta prefissi.
is_si_unit(U) :-
    is_base_si_unit(U).
is_si_unit(U) :-
    si_derived_unit(U, _).
is_si_unit(U1 * U2) :-
    is_si_unit(U1),
    is_si_unit(U2).
is_si_unit(U ** E) :-
    is_si_unit(U),
    integer(E).

% UnitÃ  derivate SI: si_derived_unit(Simbolo, Espressione)
si_derived_unit('N', kg * m / s ** 2).         % Newton
si_derived_unit('J', kg * m ** 2 / s ** 2).    % Joule
si_derived_unit('Pa', kg / (m * s ** 2)).      % Pascal
si_derived_unit('W', kg * m ** 2 / s ** 3).    % Watt
si_derived_unit('Hz', 1 / s).                  % Hertz
si_derived_unit('C', s * 'A').                 % Coulomb
si_derived_unit('V', kg * m ** 2 / (s ** 3 * 'A')). % Volt
si_derived_unit('F', s ** 4 * 'A' ** 2 / (kg * m ** 2)). % Farad
si_derived_unit('omega', kg * m ** 2 / (s ** 3 * 'A' ** 2)). % Ohm
si_derived_unit('S', s ** 3 * 'A' ** 2 / (kg * m ** 2)). % Siemens
si_derived_unit('Wb', kg * m ** 2 / (s ** 2 * 'A')). % Weber
si_derived_unit('T', kg / (s ** 2 * 'A')).     % Tesla
si_derived_unit('H', kg * m ** 2 / (s ** 2 * 'A' ** 2)). % Henry
si_derived_unit(lm, cd).                     % Lumen (semplificato)
si_derived_unit(lx, cd / m ** 2).            % Lux (semplificato)
si_derived_unit('Bq', 1 / s).                  % Becquerel
si_derived_unit('Gy', m ** 2 / s ** 2).        % Gray
si_derived_unit('Sv', m ** 2 / s ** 2).        % Sievert
si_derived_unit(kat, mol / s).               % Katal
si_derived_unit('DC', 'K').
si_derived_unit(rad, * ).
si_derived_unit(sr, * ).

% UnitÃ  non SI ma usata per i multipli
grammo_base(kg).

% Prefissi SI (nome, simbolo, fattore)
si_prefix(chilo, k, 1e3).
si_prefix(etto, h, 1e2).
si_prefix(deca, da, 1e1).
si_prefix(deci, d, 1e-1).
si_prefix(centi, c, 1e-2).
si_prefix(milli, m, 1e-3).
si_prefix(micro, 'Î¼', 1e-6).
si_prefix(nano, n, 1e-9).
si_prefix(pico, p, 1e-12).

% UnitÃ  base SI
si_unit_symbol(metro, m).
si_unit_symbol(chilo-grammo, kg).
si_unit_symbol(secondo, s).
si_unit_symbol('Ampere', 'A').
si_unit_symbol('Kelvin', 'K').
si_unit_symbol(mole, mol).
si_unit_symbol(candela, cd).
si_unit_symbol(grammo, g).
si_unit_symbol('Becquerel', 'Bq').
si_unit_symbol('degree Celsius', 'DC').
si_unit_symbol('Coulomb', 'C').
si_unit_symbol('Farad', 'F').
si_unit_symbol('Gray', 'Gy').
si_unit_symbol('Hertz', 'Hz').
si_unit_symbol('Henry', 'H').
si_unit_symbol('Joule', 'J').
si_unit_symbol('Katal', kat).
si_unit_symbol(lumen, lm).
si_unit_symbol(lux, lx).
si_unit_symbol('Newton', 'N').
si_unit_symbol('Ohm', 'omega').
si_unit_symbol('Pascal', 'Pa').
si_unit_symbol(radian, rad).
si_unit_symbol('Siemens', 'S').
si_unit_symbol('Sievert', 'Sv').
si_unit_symbol(steradian, sr).
si_unit_symbol('Tesla', 'T').
si_unit_symbol('Volt', 'V').
si_unit_symbol('Watt', 'W').
si_unit_symbol('Weber', 'Wb').

% UnitÃ  con prefisso: si_unit_symbol(NomeUnitÃ , Simbolo)
si_unit_symbol(NomePrefisso-Unita, SimboloPrefissoSimboloUnita) :-
    atom(NomePrefisso),
    atom(Unita),
    si_prefix(NomePrefisso, SimboloPrefisso, _),
    si_unit_symbol(Unita, SimboloUnita),
    atom_concat(SimboloPrefisso, SimboloUnita, SimboloPrefissoSimboloUnita).

% Operazione inversa a quella precedente
si_unit_name(S, N) :-
    si_unit_symbol(N, S).
si_unit_name(S, Prefisso-NomeUnita) :-
    si_prefix(Prefisso, SimboloPrefisso, _),
    si_unit_symbol(NomeUnita, SimboloUnita),
    atom_concat(SimboloPrefisso, SimboloUnita, S).


% Result Ã¨ < se U1 < U2, > se U1 > U2, = se U1 = U2 (in termini di grandezza)
%puo' prendere come parametri sia i simboli sia i nomi delle unita'
%es. cm o centi-metro. NON puo' prendere come parametri, invece, le potenze
%di unita' (le relazioni d'ordine rimangono uguali es.cm < m e cm ** 2 <m ** 2)
compare_units(Result, U1, U2) :-
    unit_factor(U1, F1, Base1),
    unit_factor(U2, F2, Base2),
    Base1 = Base2, % devono essere la stessa unitÃ  base
    ( F1 < F2 -> Result = '<'
    ; F1 > F2 -> Result = '>'
    ; F1 =:= F2 -> Result = '='
    ).

% Calcola il fattore numerico per determinare l'ordine nel predicato
% compare_units associato all'unitÃ  (considerando il prefisso)
%puo' prendere come parametri sia i simboli sia i nomi delle unita'
%es. cm o centi-metro. NON puo' prendere come parametri, invece, le potenze
%di unita'.
unit_factor(U, 1, U) :-
    si_unit_symbol(_, U). % unitÃ  senza prefisso
unit_factor(Prefisso-Nome, Fattore, Base) :-
    si_prefix(Prefisso, _, F),
    si_unit_symbol(Nome, Base),
    Fattore = F.
unit_factor(Nome, 1, Base) :-
    si_unit_symbol(Nome, Base).
unit_factor(U, F, Base) :-
    atom(U),
    atom_chars(U, [First|_]),
    si_prefix(_, SimboloPrefisso, F),
    atom_chars(SimboloPrefisso, [First|_]),
    si_unit_symbol(_, Base),
    atom_concat(SimboloPrefisso, Base, U).

% Espansione canonica in unita' base di unita' derivate.
%accetta anche unita' derivate con prefisso.
si_unit_base_expansion(U, Exp) :-
    % Caso unitÃ  base SI
    is_base_si_unit(U), !,
    Exp = U.
si_unit_base_expansion(U, Exp) :-
    % Caso unitÃ  derivata SI
    si_derived_unit(U, Exp), !.

si_unit_base_expansion(U, Exp) :-
    % Caso simbolo con prefisso (es. cm, mg)
    atom(U),
    si_prefix(_, SimboloPrefisso, _),
    atom_length(SimboloPrefisso, LungPref),
    sub_atom(U, 0, LungPref, _, SimboloPrefisso),
    sub_atom(U, LungPref, _, _, SimboloUnita),
    si_unit_base_expansion(SimboloUnita, Exp).

%restituisce true se Simbolo e' un unita' con prefisso e BaseUnita e' la sua
%unita' senza prefisso.
check_prefixed_unit(Simbolo, BaseUnita) :-
    decompose_prefixed_unit(Simbolo, _, BaseUnita, _).

% Dimensione valida: unitÃ  base o derivata SI
is_dimension(Dim) :-
    is_si_unit(Dim).
is_dimension(Simbolo) :-
    atom(Simbolo),
    check_prefixed_unit(Simbolo, BaseUnita),
    is_si_unit(BaseUnita).
is_dimension(Dim1 * Dim2) :-
    is_dimension(Dim1),
    is_dimension(Dim2).
is_dimension(Dim ** E) :-
    is_dimension(Dim),
    integer(E).

% QuantitÃ  valida
is_quantity(q(Value, Dim)) :-
    number(Value),
    is_dimension(Dim).

% Conversione dimensione in lista [(unitÃ , esponente)]
%il secondo argomento sara'una lista di terms (unita esponente fattore),
%dove fattore e' il valore per cui moltiplicare l'unita' senza prefisso
%per arrivare alla unita' con prefisso es. cm -> 0.01. Tiene conto di esponenti
%es. cm**2 ha fattore 0.0001.
dim_to_list(U1 * U2, List) :-
    dim_to_list(U1, L1),
    dim_to_list(U2, L2),
    append(L1, L2, List).
dim_to_list(U, [(Base, E, Fattore)]) :-
    atom(U),
    decompose_prefixed_unit(U, _, Base, Fattore),
    E = 1, !.
dim_to_list(U ** E, [(Base, E, Fattmul)]) :-
    atom(U),
    decompose_prefixed_unit(U, _, Base, Fattore),
    Efatt is log10(Fattore),
    Fattmul is 10 ** (Efatt * E),
    !.

dim_to_list(U ** E, [(U, E, 1)]) :- is_si_unit(U),!.
dim_to_list(g, [(kg, 1, 0.001)]) :-!.
dim_to_list(U, [(U, 1, 1)]) :-
    is_base_si_unit(U), !.
dim_to_list(U, [(U, 1, 1)]) :-
    si_derived_unit(U, _),!.

% Somma esponenti per unitÃ  duplicate
%somma esponenti (e fattori) che hanno unita'(senza prefisso) uguale.
%es. (m 1 1) e (m 1 1) diventa (m 2 1).
merge_units(Units, Merged) :-
    merge_units_(Units, [], Merged).

merge_units_([], Acc, Acc).
merge_units_([(U, E, F)|T], Acc, Result) :-
    ( select((U, E0, F0), Acc, Rest) ->
        E1 is E + E0,
        F1 is F * F0,
        merge_units_(T, [(U, E1, F1)|Rest], Result)
    ;
        merge_units_(T, [(U, E, F)|Acc], Result)
    ).

% decompose_prefixed_unit(Simbolo, Prefisso, BaseUnita, Fattore)
%dato Simbolo, restituisce Prefisso, BaseUnita, Fattore
%es. (cm, X, Y, Z) X = c Y = m, Z = 1e-2(prolog sceglie tra formato 1eX o
%0.000...1)
decompose_prefixed_unit(Simbolo, Prefisso, BaseUnita, Fattore) :-
    atom(Simbolo),
    si_prefix(_, Prefisso, Fattore),
    atom_length(Prefisso, PrefLung),
    sub_atom(Simbolo, 0, PrefLung, _, Prefisso),
    sub_atom(Simbolo, PrefLung, _, _, BaseUnita),
    %kg non deve assumere prefissi es mkg sbagliato
    dif(BaseUnita, 'kg'),
    is_si_unit(BaseUnita).

%caso prefisso + grammo
decompose_prefixed_unit(Simbolo, Prefisso, BaseKg, FattNew) :-
    atom(Simbolo),
    si_prefix(_, Prefisso, Fattore),
    atom_length(Prefisso, PrefLung),
    sub_atom(Simbolo, 0, PrefLung, _, Prefisso),
    sub_atom(Simbolo, PrefLung, _, _, BaseUnita),
    BaseUnita = 'g',
    BaseKg = 'kg',
    atom_number('0.001', ExpTen),
    FattNew is Fattore * ExpTen.

% expt_base_unit(Unita, Esponente, Base, FattoreTotale)
%unita e' un unita si anche con prefisso, esponente e' il suo esponente
%Base e' l'unita' base corrispondente a Unita', FattoreTotale e' il fattore
%corretto per l'unita'con esponente. Es. cm -> 0.01 cm**2 -> 0.0001
expt_base_unit(U, E, UnitaBase, FattoreTotale) :-
    decompose_prefixed_unit(U, _, UnitaBase, Fattore),
    FattoreTotale is Fattore ** E.
expt_base_unit(U, _, U, 1) :-
    is_base_si_unit(U).

%ricostruisce una dimensione trasformata in lista con la dim_to_list.
%il formato utilizzato e' unita**esponente*fattore. Aggiunge parentesi.
list_to_dim([], 1).
list_to_dim([(U, E, F)], U ** E * F) :- !.
list_to_dim([(U, 1, F)|T], U ** 1 * F * D) :-
    list_to_dim(T, D).
list_to_dim([(U, E, F)|T], U ** E * F * D) :-
    list_to_dim(T, D).
%no fattori
list_to_dim([(U, E)], U ** E) :- !.
list_to_dim([(U, E)|T], U ** E * D) :-
    list_to_dim(T, D).

% Normalizza una dimensione: somma esponenti, 
% elimina esponenti nulli, associa a sinistra, ordina.
%mantiene i fattori es. norm(cm, X) X = m**1*0.01.
norm(Dim, NewDim) :-
    dim_to_list(Dim, List),
    merge_units(List, Merged),
    exclude_zero_exponents(Merged, Cleaned),
    dim_sort(Cleaned, Sorted),
    list_to_dim(Sorted, NewDim).

%Normalizza analogamente alla funzione norm, ma NON restituisce i fattori.
norm_no_fatt(Dim, NewDim) :-
    dim_to_list(Dim, List),
    merge_units(List, Merged),
    exclude_zero_exponents(Merged, Cleaned),
    dim_sort(Cleaned, Sorted),
    remove_factor(Sorted, Factorless),
    list_to_dim(Factorless, NewDim).

%dato primo argomento una lista di triple (unita exp fatt), le ordina secondo
%la loro unita'. utilizza predicati che hanno a che fare con i pairs.
dim_sort(List, SortedList) :-
    order_list(List, OrderValueList),
    pairs_keys_values(PairList, OrderValueList, List),
    keysort(PairList, SortedPairList),
    pairs_values(SortedPairList,SortedList).


%true se il secondo argomento e' una lista con i valori che determinano
%l'ordine delle unita' appartenenti alla lista di primo
%argomento di (unita exp fatt).
order_list([],[]).
order_list([D1 | DRest], [UnitNo | URest]) :-
    term_string(D1, SD1),
    sub_string(SD1, Len, 1, _, ","),
    sub_string(SD1, 0, Len, _, SUnit),
    term_string(Unit, SUnit),
    units_order(Unit, UnitNo),
    order_list(DRest, URest).

%stabilisce l'ordine delle unita', utile per il sorting.
units_order(kg, 1).
units_order(m, 2).
units_order(s, 3).
units_order('A', 4).
units_order('K', 5).
units_order(cd, 6).
units_order(mol, 7).
units_order('Bq', 8).
units_order('DC', 9).
units_order('C', 10).
units_order('F', 11).
units_order('Gy', 12).
units_order('Hz', 13).
units_order('H', 14).
units_order('J', 15).
units_order(kat, 16).
units_order(lm, 17).
units_order(lx, 18).
units_order('N', 19).
units_order('omega', 20).
units_order('Pa', 21).
units_order(rad, 22).
units_order('S', 23).
units_order('Sv', 24).
units_order(sr, 25).
units_order('T', 26).
units_order('V', 27).
units_order('W', 28).
units_order('Wb', 29).

%prende una lista di (unita exp fatt) con fattore e restituisce una
%lista con le unita' senza fattore, in formato (unita exp).
remove_factor([],[]).
remove_factor([CL|CLs], [SenzaFatt| Ls]) :-
    term_string(CL, SCL),
    split_string(SCL, ",", " ", L),
    nth0(0, L, PrimoF),
    nth0(1, L, Secondo),
    string_concat("(", PrimoF, Primo),
    string_concat(Primo, ", ", PrimoSpaz),
    string_concat(PrimoSpaz, Secondo, MancaPar),
    string_concat(MancaPar, ")" , SenzaFattStr),
    term_string(SenzaFatt, SenzaFattStr),
    remove_factor(CLs, Ls).

%e' vero se il primo argomento e' una lista di (unita exp fatt), e se il
%secondo argomento e' la stessa lista del primo meno tutte le
%(unita exp fatt) di cui exp =:= 0.
exclude_zero_exponents([], []).
exclude_zero_exponents([(U, E, F)|T], R) :-
    (E =:= 0 -> exclude_zero_exponents(T, R)
    ; R = [(U, E, F)|Rest], exclude_zero_exponents(T, Rest)
    ).

%e' vero se F e' il fattore di Dim (Dim e'una dimensione NON necessariamente
%in forma canonica, non dev'essere ottenuta tramite norm.)
extract_factor(Dim, F) :-
    dim_to_list(Dim, List),
    extract_factor_list(List, F).

extract_factor_list([], 1).
extract_factor_list([(_, _, F1)|T], F) :-
    extract_factor_list(T, FRest),
    F is F1 * FRest.

%TUTTI I PREDICATI SOTTOSTANTI CHE FANNO RIFERIMENTO A QUANTITÁ intendono
%quantita' secondo il formato q(numero dimensione).
% Somma tra quantitÃ  (solo se dimensioni compatibili)

qadd(Q1, Q2, q(V3, NND1)) :-
    is_quantity(Q1),
    is_quantity(Q2),
    Q1 = q(V1, D1),
    Q2 = q(V2, D2),
    norm_no_fatt(D1, NND1),
    norm_no_fatt(D2, NND2),
    NND1 = NND2,
    extract_factor(D1, F1),
    extract_factor(D2, F2),
    V1base is V1 * F1,
    V2base is V2 * F2,
    V3 is V1base + V2base.


% Sottrazione tra quantitÃ  (solo se dimensioni compatibili)
qsub(Q1, Q2, q(V3, NND1)) :-
    is_quantity(Q1),
    is_quantity(Q2),
    Q1 = q(V1, D1),
    Q2 = q(V2, D2),
    norm_no_fatt(D1, NND1),
    norm_no_fatt(D2, NND2),
    NND1 = NND2,
    extract_factor(D1, F1),
    extract_factor(D2, F2),
    V1base is V1 * F1,
    V2base is V2 * F2,
    V3 is V1base - V2base.

% Moltiplicazione tra quantitÃ 
qmul(Q1, Q2, q(V3, ND1)) :-
    is_quantity(Q1),
    is_quantity(Q2),
    Q1 = q(V1, D1),
    Q2 = q(V2, D2),
    dim_to_list(D1, LD1),
    dim_to_list(D2, LD2),
    append(LD1, LD2, LD3),
    merge_units(LD3, Merged),
    exclude_zero_exponents(Merged, Cleaned),
    dim_sort(Cleaned, Sorted),
     remove_factor(Sorted, Factorless),
    extract_factor(D1, F1),
    extract_factor(D2, F2),
    V3 is V1 * V2 * F1 * F2,
    list_to_dim(Factorless, ND1).
    

% Divisione tra quantitÃ 
qdiv(Q1, Q2, q(V3, ND1)) :-
    is_quantity(Q1),
    is_quantity(Q2),
    Q1 = q(V1, D1),
    Q2 = q(V2, D2),
    V2 =\= 0,
    dim_to_list(D1, LD1),
    dim_to_list(D2, LD2),
    negate_exp_list(LD2, NegLD2),
    append(LD1, NegLD2, LD3),
    merge_units(LD3, Merged),
    exclude_zero_exponents(Merged, Cleaned),
    dim_sort(Cleaned, Sorted),
     remove_factor(Sorted, Factorless),
    extract_factor(D1, F1),
    extract_factor(D2, F2),
    V3 is (V1 * F1) / (V2 * F2),
    list_to_dim(Factorless, ND1).

%nega gli esponenti(secondo elem) di una lista di (u exp fatt).
negate_exp_list([],[]).
negate_exp_list([CL | CLs], [Negato| Ls]) :-
    term_string(CL, SCL),
    split_string(SCL, ",", " ", L),
    nth0(1, L, EsponenteStr),
    nth0(0, L, PrimoF),
    nth0(2, L, TerzoF),
    number_string(Esponente, EsponenteStr),
    EsponenteNegato is Esponente * -1,
    number_string(EsponenteNegato, EsponenteNegatoStr),
    %ricostruisce la stringa dopo split_string
    string_concat("(", PrimoF, Primo),
    string_concat(Primo, ", ", PrimoSpaz),
    string_concat(PrimoSpaz, EsponenteNegatoStr, MancaTerzoVir),
    string_concat(MancaTerzoVir, ", ", MancaTerzo),
    string_concat(MancaTerzo, TerzoF , SenzaParentesi),
    string_concat(SenzaParentesi, ")", NegatoStr),
    term_string(Negato, NegatoStr),
    negate_exp_list(CLs, Ls).

%e' vero quando il terzo argomento e' il risultato dell'elevamento a potenza
%del primo argomento(una quanitita') con esponente secondo argomento, un
%numero intero positivo.
qexp(Q1, 1, Q1).
qexp(Q1, N, QresTotal) :-
    is_quantity(Q1),
    integer(N),
    NMinus is N-1,
    qexp(Q1, NMinus, QresPartial),
    qmul(Q1, QresPartial, QresTotal).
    
