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