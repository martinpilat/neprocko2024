% swi-prolog
% https://swish.swi-prolog.org/

:- use_module(library(clpfd)).

muz(adam).
muz(karel).

zena(jitka).

super_rodic(X,Y):-rodic(X,Y),X\=Y.

rodic(jitka, adam).
rodic(jitka, karel).
rodic(jitka, jitka).

otec(X, Y):-rodic(X, Y),muz(X).
rodic_ktery_neni_muz(X,Y):-rodic(X, Y), \+muz(X).

bratr(X, Y):-rodic(Z,X),rodic(Z,Y),
             muz(X),X \= Y.

reseni(p(o(J1, L1, O1), o(J2, L2, O2), o(J3, L3, O3))):-
 ((O1=win, L1=cs);(O2=win, L2=cs);(O3=win, L3=cs),
 (J1=bill, O2=mac); (J2=bill, O3=mac); (O1=mac, J2=bill)).

