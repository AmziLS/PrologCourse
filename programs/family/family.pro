parent(michael, diego).
parent(ana, diego).
parent(pilar, ana).

male(michael).
male(diego).

female(ana).
female(pilar).

mother(M, C) :-
   parent(M, C),
   female(M).

ancestor(A, C) :-
   parent(A, C).
ancestor(A, C) :-
   parent(X, C),
   ancestor(A, X).
