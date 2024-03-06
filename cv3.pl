otoc(Xs, Sx):-otoc(Xs, [], Sx).
otoc([], A, A).
otoc([X|Xs], A, Sx):-A1 = [X|A],
                     otoc(Xs, A1, Sx).

soucet(Xs, Sx):-soucet(Xs, 0, Sx).
soucet([], A, A).
soucet([X|Xs], A, Sx):-A1 is A + X,
                       soucet(Xs, A1, Sx).

%vypustVse(Xs, X, S):-S je seznam Xs bez vyskytu X
vypustVse([], _, []).
vypustVse([X|Xs], X, S):-vypustVse(Xs, X, S).
vypustVse([Y|Xs], X, [Y|S1]):-dif(X,Y),vypustVse(Xs, X, S1).

%vypustVseSelzi(Xs, X, S, P):-to same, ale selze pokud X neni v Xs, P je pocet
%                            vypustenych prvku
vypustVseSelzi(Xs, X, S, P):-vypustVseSelzi(Xs, X, 0, S, P).
vypustVseSelzi([], _, A, [], A):-A>0.
vypustVseSelzi([X|Xs], X, A, S, P):-A1 is A + 1, 
                                 vypustVseSelzi(Xs, X, A1, S, P).
vypustVseSelzi([Y|Xs], X, A, [Y|S1], P):-dif(X, Y),
                                 vypustVseSelzi(Xs, X, A, S1, P).

%zbytek je implementace merge sortu

%split(X, X1, X2):- rozdeli X na seznamy X1 a X2 - X1 jsou prvky na lichych
%                   pozicich, X2 jsou prvky na sudych pozicich
split([], [], []).
split([X], [X], []).
split([X,Y|Xs], [X|X1], [Y|Y1]):-split(Xs, X1, Y1).


%merge(X1, X2, X):-X je setrideny seznam, ktery vznikne slitim 
%                  setridenych seznamu X1 a X2
merge([], X, X).
merge(X, [], X).
merge([X|Xs], [Y|Ys], [X|Zs]):- X < Y, merge(Xs, [Y|Ys], Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]):- Y =< X, merge([X|Xs], Ys, Zs).

%merge_sort(X, S):-S je seznam obsahujici setridene hodnoty ze seznamu X
merge_sort([], []):-!.
merge_sort([X], [X]):-!.
merge_sort(X, S):-split(X, X1, X2),
                  merge_sort(X1, S1),
                  merge_sort(X2, S2),
                  merge(S1, S2, S).