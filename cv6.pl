% prevod reprezentace grafu ze seznamu hran na seznam nasledniku a naopak
grafSHnaSN(grafSH(V, SH), grafSN(V, SN)):-
    bagof(VV-SSN,
        (member(VV,V),bagof(N, member(VV-N, SH), SSN))
    ,SN).

grafSNnaSH(grafSN(V, SN), grafSH(V, SH)):-
    bagof(Y-X, Z^(member(Y-Z, SN),member(X, Z)), SH).

% predikat pro hranu, ukazka pouziti call pro castecne aplikovani paramteru
hrana(A,B,grafSH(_, SH)):-member(A-B, SH).
hrana(A, B):-call(hrana(A, B), grafSH([1,2,3,4,5], [1-2,1-3,2-3,2-5])).

% hledani sledu v grafu
sled(_, Z, Z, _).
sled(H, Z, Do, G):-call(H, Z, K, G),sled(H, K, Do, G).

:-dynamic max_d/1.

% nasleduje opravene reseni ze cviceni, ted uz kontrola prohledani celeho prostoru
% funguje spravne 
% opravy: if potrebuje vzdy i else vetvi (jinak selze, pokud selze podminka)
% v iterDeep byly pridany rezy a explicitni fail, pokud cesta neni nalezena ani
% po projiti celeho prostoru
% kouknete do souboru cv6-upravene.pl pro elegantnejsi reseni (ale bez ukonceni
% po prohledani celeho prostoru)

% hledani cesty, upravene pro iterovane prohlubovani s ukoncenim pro prohledani
% celeho prostoru
% zakladni hledani cesty muze vynechat vsechny radky/parametry s MD/retractall/assert
cesta(H, Z, Do, C, G):-cesta(H, Z, Do, C, [Z], 1, G).
cesta(_, Z, Z, [Z], _, _, _).
cesta(H, Z, Do, [Z|A], N, D, G):-call(H, Z, K, G),
                                 \+member(K, N),
                                 max_d(MD),
                                 D1 is D + 1,
                                 (D > MD -> 
                                    retractall(max_d(_)), assert(max_d(D1));
                                    true
                                 ),
                                 cesta(H, K, Do, A, [K|N], D1, G).

iterDeep(H, Z, Do, C, G):-between(1,inf,D),length(C, D),
                          retractall(max_d(_)),assert(max_d(0)),
                          (cesta(H, Z, Do, C, G) -> 
                            !; 
                            max_d(MD), MD < D, !, fail
                          ).