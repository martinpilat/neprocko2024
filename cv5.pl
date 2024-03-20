% pridejBVS(+X,+S,-SX):-SX je strom S s pridanym X
pridejBVS(X, nil, t(nil, X, nil)).
pridejBVS(X, t(LP, H, PP), t(NLP, H, PP)):-
    X < H,!,pridejBVS(X, LP, NLP).
pridejBVS(X, t(LP, H, PP), t(LP, H, NPP)):-
    pridejBVS(X, PP, NPP).

% seznamNaBVS(+S, -BVS):-BVS je binarni vyhledavaci strom, 
%                         ktery obsahuje prave prvky S
seznamNaBVS1([], nil).
seznamNaBVS1([X|Xs], BVS):-seznamNaBVS1(Xs, BVS1),
                           pridejBVS(X, BVS1, BVS).

seznamNaBVS2(S, BVS):-seznamNaBVS2(S, nil, BVS).
seznamNaBVS2([], A, A).
seznamNaBVS2([X|Xs], A, BVS):-pridejBVS(X, A, A1),
                              seznamNaBVS2(Xs, A1, BVS).

% porovnejme seznamNaBVS2 se soucet/2 z cv3 -> struktura je skoro stejna, foldl
% soucet(Xs, Sx):-soucet(Xs, 0, Sx).
% soucet([], A, A).
% soucet([X|Xs], A, Sx):-A1 is A + X,
%                        soucet(Xs, A1, Sx).

seznamNaBVS3(S, BVS):-foldl(pridejBVS, S, nil, BVS).

%member_tree(-X, +T):-X je prvek stromu T
% zmenou poradi nasledujicich 3 radek muzeme menit poradi pruchodu - inorder/preorder/postorder
member_tree(X, t(LP, _, _)):-member_tree(X, LP).
member_tree(X, t(_, X, _)).
member_tree(X, t(_, _, PP)):-member_tree(X, PP).

% jednoradkova implementace toho sameho pomoci ;
member_tree2(X, t(LP, H, PP)):-X = H; 
                              member_tree2(X, LP);
                              member_tree2(X, PP).