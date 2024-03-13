:-use_module(library(clpfd)).

%podseznam(X, S):-X je podseznam S
podseznam([], []).
podseznam([X|Z], [X|Xs]):-podseznam(Z, Xs).
podseznam(Z, [_|Xs]):-podseznam(Z,Xs).

%podmnozina(X, S):-jako podseznam, ale nezalezi na poradi
podmnozina([], _).
podmnozina([X|Xs], S):-select(X, S, SX),
                       podmnozina(Xs, SX).

%soucet_podmnoziny(S, N, X):-X je podseznam S se souctem presne N
soucet_podmnoziny(_, 0, []):-!.
soucet_podmnoziny([X|Xs], N, [X|Z]):-
                N1 is N - X,
                soucet_podmnoziny(Xs, N1, Z).
soucet_podmnoziny([_X|Xs], N, Z):-
                soucet_podmnoziny(Xs, N, Z).

%pricti1(X, Y):-Y je seznam X, kde je kazdy prvek o jedna vetsi
pricti1([], []).
pricti1([X|Xs], [X1|Z]):-X1 is X + 1, 
                         pricti1(Xs, Z).

%plus1(X, Y):- Y je X + 1, pouzite jako ukazka maplist(plus1, [1,2,3], [2,3,4])
plus1(X, Y):-Y #= X + 1. % clpfd se pouziva jen zde

%zipuj(X,Y,[X,Y]):- pouzite jako ukazka maplist s vice parametry
zipuj(X, Y, [X,Y]).

%zip(X, Y, Z):- Z je seznam dvojic Xi, Yi
zip([], _, []).
zip(_, [], []).
zip([X|Xs], [Y|Ys], [[X,Y]|Zs]):-
                        zip(Xs, Ys, Zs).

%map(P, S, SV):-SV vznikne "mappem" P na seznam S
map(_, [], []).
map(P, [X|Xs], [Z|Zs]):-call(P, X, Z),
                        map(P, Xs, Zs).

%map(P, S1, S2, SV):-SV vznikne mappem P na seznamy S1, S2
map(_, _, [], []).
map(_, [], _, []).
map(P, [X|Xs], [Y|Ys], [Z|Zs]):-call(P, X, Y, Z),
                                map(P, Xs, Ys, Zs).