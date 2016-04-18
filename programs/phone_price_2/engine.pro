/*
Pricer 2

Illustrates a custom rule engine for pricing rules like these:

If a call was made on a weekend the price is 5 cents a minute.
If a call was made during the week after 8pm the price is 7 cents a minute.
If a call was made during the week before 8pm the price is 10 cents a minute.
*/

:- include('opdefs.pro').

% Test Loop

main :-
   phone_call(ID, _, _, _),
   price_call(ID, Price),
   write(ID = Price),
   nl,
   fail.
main.

price_call(ID, P) :-
   phone_call(ID, Day, Start, Duration),
   init,
   assert(known(duration, Duration)),
   assert(known(start, Start)),
   assert(known(day, Day)),
   solve(price, P).

init :-
   retractall(known(_,_)).

% Reasoning Engine

solve(Attr, Val) :-
   find(Attr, Val).

find(Attr, Val) :-
   known(Attr, X),
   !,
   Val = X.
find(Attr, Val) :-
   rule(R, RuleAttrs),
   get_slot(goal, Attr = X, RuleAttrs),
   get_slot(conditions, Conds, RuleAttrs),
   prove(Conds),
   eval(X, V),
   assert(known(Attr, V)),
   !,
   Val = V.

prove( C1 and C2 ) :-
   prove(C1),
   prove(C2).
prove(C1 or C2) :-
   ( prove(C1)
     ;
     prove(C2) ).

prove(A = V) :-
   find(A, V).
prove(Attr \= Val) :-
   find(Attr, V),
   V \= Val.
prove(Attr < Val) :-
   find(Attr, V),
   V < Val.
prove(Attr >= Val) :-
   find(Attr, V),
   V >= Val.

eval(A, V) :-
   known(A, V),
   !.
eval(E1 * E2, V) :-
   eval(E1, V1),
   eval(E2, V2),
   V is V1 * V2,
   !.
eval(V, V).

get_slot(Slot, Val, [Slot :: Val | _]) :-
   !.
get_slot(Slot, Val, [_ | Slots]) :-
   !,
   get_slot(Slot, Val, Slots).
