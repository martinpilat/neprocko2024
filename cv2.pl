test1([1,2,3,4,5]).

%prvek(?X, ?S):-X je prvek seznamu S
prvek(X, [X|_]).
%prvek(?X, ?S):-X je prvek seznamu S
prvek(X, [_|H]):-prvek(X, H).

%najdi(?K,?S,?V):-S je seznam dvojic Klic-Hodnota, K je klic a V je jemu prislusna hodnota v S
najdi(K, S, V):-member(K-V, S).

%usprodane_dvojice(+X, +Y, -Z):-Z je usporadana dvojice prvku ze seznamu X a Y
usporadane_dvojice(Xs, Ys, X-Y):-
    member(X, Xs), member(Y, Ys).

%generuj_rev(+N, -S):-S je seznam hodnot [N, N-1, N-2, ..., 1]
generuj_rev(1, [1]).
generuj_rev(N, [N|S1]):-N>1, N1 is N - 1,
    generuj_rev(N1, S1).

%generuj(+N, -S):-S je seznam cisel [1, 2, 3, ..., N]
% priste ukazeme jeste efektivnejsi verzi (bez reverse)
generuj(N, S):-generuj_rev(N, S1), 
               reverse(S1, S).

%pridejk(+X, +S, -SX):-SX je seznam S s X pripojenym na konci
pridejk(X, [], [X]).
pridejk(X, [S|Ss], [S|Z]):-pridejk(X, Ss, Z).

%otoc(+Seznam, -Manzes):-Manzes je Seznam pozpatku
% toto je velmi neefektivni reseni - priste ukazeme lepsi
otoc([],[]).
otoc([X|Xs], Z1):-otoc(Xs, Z), pridejk(X, Z, Z1).