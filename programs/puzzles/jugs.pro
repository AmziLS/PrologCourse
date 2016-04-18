% Given an 8 liter jug full of water and empty
% 5 liter and 3 liter jugs with no markings, how can you
% split the water so there are 4 liters in each of the
% two larger jugs?
%
% Use the same strategy as in the fox.pro program.
%
% initial_state(...).
% final_state(...).
%
% move(S1, S2) ...
% move(S1, S2) ...
% ...
%
% solve(State, Path, Solution) ...
% solve(State, Path, Solution) ...
%

:- ensure_loaded(list).
:- import(list).

initial_state( jugs(8-8,5-0,3-0) ).

final_state( jugs(8-4,5-4,3-0) ).

move( jugs(L1, M1, S), jugs(L2, M2, S) ) :-
   pour(L1, M1, L2, M2).
move( jugs(L1, M, S1), jugs(L2, M, S2) ) :-
   pour(L1, S1, L2, S2).
move( jugs(L, M1, S1), jugs(L, M2, S2) ) :-
   pour(M1, S1, M2, S2).
move( jugs(L1, M1, S), jugs(L2, M2, S) ) :-
   pour(M1, L1, M2, L2).
move( jugs(L1, M, S1), jugs(L2, M, S2) ) :-
   pour(S1, L1, S2, L2).
move( jugs(L, M1, S1), jugs(L, M2, S2) ) :-
   pour(S1, M1, S2, M2).

pour( FromCapacity-FromAmt1, ToCapacity-ToAmt1, FromCapacity-FromAmt2, ToCapacity-ToAmt2) :-
   Space is ToCapacity - ToAmt1,
   (FromAmt1 >= Space ->
      FromAmt2 is FromAmt1 - Space,
      ToAmt2 = ToCapacity
      ;
      FromAmt2 = 0,
      ToAmt2 is ToAmt1 + FromAmt1).
      
   
main :-
   initial_state(S1),
   solve(S1, [S1], Solution),
   write_list(Solution, `\n`),
   nl, nl,
   fail.
main.

solve(S1, SoFar, Solution) :-
   final_state(S1),
   reverse( SoFar, Solution ).
solve(S1, SoFar, Solution) :-
   move(S1, S2),
   not member(S2, SoFar),
   solve(S2, [S2|SoFar], Solution).
   
% Try it with different size jugs and required final amount.

