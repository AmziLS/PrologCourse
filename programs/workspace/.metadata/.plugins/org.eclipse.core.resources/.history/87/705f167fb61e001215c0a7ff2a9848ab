% Use difference lists to create a parse tree
%
% ?- sentence( S, [the, cat, chases, the, mouse], [] ).
% ?- noun(N, L1, L2).
% ?- subject(S, L1, L2).

sentence( sentence(S,V,O), L1, L4) :-
  subject(S, L1, L2),
  verb(V, L2, L3),
  object(O, L3, L4).
  
subject(subject(M,N), L1, L3) :-
  modifier(M, L1, L2),
  noun(N, L2, L3).
  
object(object(M,N), L1, L3) :-
  modifier(M, L1, L2),
  noun(N, L2, L3).

modifier(mod(the), [the|X], X).

noun(noun(cat), [cat|X], X).
noun(noun(mouse), [mouse|X], X).
noun(noun('polar bear'), [polar,bear|X], X).

verb(verb(chases), [chases|X], X).
verb(verb(eats), [eats|X], X).
