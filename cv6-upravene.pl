% presunuti grafu jako prvniho parametru nam umozni vynechat vsude jeden parametr
% muzeme potom predikat volat jako call(hrana(grafSH(V, H), A, B))
% predikat pro hranu, ukazka pouziti call pro castecne aplikovani paramteru
hrana(grafSH(_, SH), A, B):-member(A-B, SH).

% hledani sledu v grafu
sled(_, Z, Z, _).
sled(H, Z, Do):-call(H, Z, K),sled(H, K, Do).

% hledani cesty
cesta(H, Z, Do, C):-cesta(H, Z, Do, [Z], C).
cesta(_, Z, Z, _, [Z]).
cesta(H, Z, Do, N, [Z|P]):-call(H, Z, K), 
                           \+member(K, N),
                           cesta(H, K, Do, [K|N], P).

% tato verze se zacykli, pokud cesta neexistuje
% dala by se upravit podobne jako v cv6.pl, nebo je mozne zmenit
% horni limit v between (potom se prohledava maximalne do zadane hloubky)
iterDeep(H, Z, Do, C):-between(1,inf,D),length(C, D),
                       cesta(H, Z, Do, C), !.

% implementace akci pro problem s prelevanim vody - jsou dany dve nadoby s objemy
% K1, K2 a stav V1-V2 vyjadrujici, ze v prvni nadobe je V1 litru vody a v druhe 
% nadobe je V2 litru, dale mame nekonecny zdroj vody a nekonecny odpad, kam muzeme
% vodu vylit, cilem je najit posloupnost akci nabrani/vyliti vody a preliti vody
% mezi nadobami tak, aby nakonec byl v nadobach dany objem vody
% tento predikat se da pouzit pri volani iterDeep(akce(K1, K2), V1-V2, C1-C2,P), 
% ktery pro nadoby s objemy K1,K2 najde z pocatecniho stavu V1-V2 posloupnost 
% P stavu, ktere vedou do C1-C2
akce(_, _, _-V2, 0-V2).     % vyliti prvni nadoby
akce(_, _, V1-_, V1-0).     % vyliti druhe nadoby
akce(K1, _, 0-V2, K1-V2).   % nabrani do prvni nadoby
akce(_, K2, V1-0, V1-K2).   % nabrani do druhe nadoby
% preliti z prvni nadoby do druhe
akce(K1, _, V1-V2, N1-0):-K1 >= V1 + V2, N1 is V1 + V2.
akce(K1, _, V1-V2, K1-N2):-K1 < V1 + V2, N2 is V2 - (K1 - V1).
% preliti z druhe nadoby do prvni
akce(_, K2, V1-V2, 0-N2):-K2 >= V2 + V1, N2 is V2 + V1.
akce(_, K2, V1-V2, N1-K2):-K2 < V1 + V2, N1 is V1 - (K2 - V2).