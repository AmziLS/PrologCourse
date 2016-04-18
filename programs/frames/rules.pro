:- op(850, xfx, ::).
:- op(820, xfy, or).
:- op(810, xfy, and).

% Test Data
phone_call(1, tuesday, 1800, 10).
phone_call(2, wednesday, 2200, 10).
phone_call(3, saturday, 2200, 10).
phone_call(4, monday, 1600, 10).
phone_call(5, sunday, 800, 10).

main :-
   price_calls.

% Using the test data, assert the known data
% and then call solve to find the price

price_calls :-
   consult('pricing.kb'),
   phone_call(ID, Day, Start, Duration),
   init,
   assert( known(duration, Duration) ),
   assert( known(start, Start) ),
   assert( known(day, Day) ),
   solve(price, P),
   write(id = ID), tab(2),
   write(price = P), nl,
   fail.
price_calls.

init :-
   retractall(known(_,_)).

% We called it getProperty before, but this version
% calls it get_slot/3.  Frame jargon refers to properties
% as slots.
%
% get_slot(Slot, Val, Slots)
%   Slot - slot name, either goal or conditions in the example
%   Val - the value returned
%   Slots - the list of slots (properties)
%
% ?- rule(r1, Slots), get_slot(goal, X, Slots).
% X = price = duration * 5

get_slot(Slot, Val, [ (Slot :: Val) | _]) :-
   !.
get_slot(Slot, Val, [ _ | Slots] ) :-
   get_slot(Slot, Val, Slots).

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

