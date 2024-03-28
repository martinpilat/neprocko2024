% primocare reseni bez triku
vlozOperatory([X], X, X).
vlozOperatory(S, H, E1*E2):-append(LS, PS, S),
                        LS \= [], PS \= [],
                        vlozOperatory(LS, H1, E1), 
                        vlozOperatory(PS, H2, E2),
                        H is H1 * H2.
vlozOperatory(S, H, E1+E2):-append(LS, PS, S),
                        LS \= [], PS \= [],
                        vlozOperatory(LS, H1, E1), 
                        vlozOperatory(PS, H2, E2),
                        H is H1 + H2.
vlozOperatory(S, H, E1-E2):-append(LS, PS, S),
                        LS \= [], PS \= [],
                        vlozOperatory(LS, H1, E1), 
                        vlozOperatory(PS, H2, E2),
                        H is H1 - H2.
vlozOperatory(S, H, E1/E2):-append(LS, PS, S),
                        LS \= [], PS \= [],
                        vlozOperatory(LS, H1, E1), 
                        vlozOperatory(PS, H2, E2),
                        H2 =\= 0,
                        H is H1 // H2.

% to same zkracene pomoci stredniku
% alternativni rozdeleni seznamu na neprazdne podseznamy
vlozOperatory2([X], X, X).
vlozOperatory2(S, H, E):-append([L|LS], [P|PS], S),
                        vlozOperatory2([L|LS], H1, E1), 
                        vlozOperatory2([P|PS], H2, E2),
                        (
                         (E = E1 * E2, H is H1 * H2);
                         (E = E1 + E2, H is H1 + H2);
                         (E = E1 - E2, H is H1 - H2);
                         (E = E1 / E2, H2 =\= 0, H is H1 // H2)
                        ).