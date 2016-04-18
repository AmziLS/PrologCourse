% Using Chinese characters works for listener,
% but not for debugger, or cross reference.

parent(michael, diego).
parent(ana, diego).
parent(pilar, ana).
parent('Dennis Merritt', michael).

parent(㑁㐵㕆, 㑁㚒㘟).
parent(㑁㐵㕆, 㑁㚒㘦).
parent(㑁㚒㘟, 㑁㡺㡶).

male(michael).
male(diego).
male('Dennis Merritt').
male(㑁㐵㕆).
male(㑁㚒㘟).
male(㑁㡺㡶).

female(ana).
female(pilar).
female(㑁㚒㘦).

mother(M, C) :-
   parent(M, C),
   female(M).

父亲(_父, _儿童) :-
   parent(_父, _儿童),
   male(_父).

ancestor(A, C) :-
   parent(A, C).
ancestor(A, C) :-
   parent(X, C),
   ancestor(A, X).
