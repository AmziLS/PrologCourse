% A farmer has a fox, goat, and lettuce on one side of a
% river and a small boat that can only transport one of the
% three at a time to the other side.
%
% He can't leave the fox and goat alone, because the fox
% will eat the goat.  Nor can he leave the goat and lettuce
% alone.
%
% The puzzle is, what series of river crossings will get
% all three safely to the other side.
%
% Write a Prolog program that finds the solution to the puzzle.
%
% The general strategy is to define a structure that represents
% the initial state, and final state.  This would be the farmer
% and three first on one side, then on the other.
%
% Next define rules that make legal moves, taking an input state
% and generating an output state.  For example moving the fox and
% farmer from one side to the other, or moving just the farmer.
%
% Next define rules that test if a state is legal, that is make
% sure the fox and goat, or goat and lettuce aren't left alone.
%
% Next define a recursive solve predicate that starts with the
% initial state and makes moves until the end state is reached.
%
% You will have to keep an accumulator of the states reached so
% far for two reasons.  First, so you can check if a move doesn't
% bring you back to a previous state, and second so you can display
% the solution at the end.
%
% Good luck.
%

:- ensure_loaded(list).
:- import(list).

%---------------------------------------------------------------
% Initial and final states.
%
% There are many ways to represent the state.  It is a key
% decision in the program.  It should be a structure or list.
%
% Some ideas for when the goat is on the other side:
%    state( farmer(here), fox(here), goat(there), lettuce(here) )
%    state( here([farmer, fox, lettuce]), there([goat]) )
%    state( [at(farmer,here), at(fox,here), at(goat,there), at(lettuce,here)] )
%
% Given that this puzzle has a simple state, and contraints between
% fixed entities, maybe the static fixed structure is better than the
% ones with lists.  The lists might be better for a more complex
% puzzle.
%
% However you decide, create two facts:
%
% initial_state( S1 ).
% final_state( S2 ).
%
% where S1 and S2 are your state representations for the start
% and finish of the puzzle.  That is, all four elements either
% on this side or that.
%

initial_state( state(farmer(here), fox(here), goat(here), lettuce(here)) ).
final_state( state(farmer(there), fox(there), goat(there), lettuce(there)) ).

%-------------------------------------------------------
% Moves
%
% write a number of clauses of the form:
%
%   move( S1, S2 ) ...
%
% where each is a legal move.  That is, moving
% the farmer and one item or the farmer alone
% from one side to the other.
%
% S1 & S2 - the beginning and ending state for
%   the move.
%
% It's an option to have a third argument, M, that
% might note the move for use in output, such as
% move(goat,there).
%

swap(here, there).
swap(there, here).

move( state(farmer(X), fox(X), goat(G), lettuce(L)),
      state(farmer(Y), fox(Y), goat(G), lettuce(L)),
      move(fox,Y) ) :-
   swap(X,Y).
move( state(farmer(X), fox(F), goat(X), lettuce(L)),
      state(farmer(Y), fox(F), goat(Y), lettuce(L)),
      move(goat,Y) ) :-
   swap(X,Y).
move( state(farmer(X), fox(F), goat(G), lettuce(X)),
      state(farmer(Y), fox(F), goat(G), lettuce(Y)),
      move(lettuce,Y) ) :-
   swap(X,Y).
move( state(farmer(X), fox(F), goat(G), lettuce(L)),
      state(farmer(Y), fox(F), goat(G), lettuce(L)),
      move(farmer,Y) ) :-
   swap(X,Y).

%-----------------------------------------------------
% Unsafe
%
% Write unsafe(S) that determines if a state is unsafe.
% In other words, if the fox and goat or goat and lettuce
% are left alone without the farmer.
%

unsafe( state(farmer(Y), fox(X), goat(X), lettuce(_)) ) :-
   X \= Y.
unsafe( state(farmer(Y), fox(_), goat(X), lettuce(X)) ) :-
   X \= Y.

%--------------------------------------------------
% Solve
%
% solve(State, PathSoFar, Solution)
%
% This recursive predicate will look something like:
%
% solve(State, ReverseSolution, Solution) :-
%    final_state(State),
%    ...
%    !.
% solve(State, PathSoFar, Solution) :-
%    move(State, State2),
%    ... some tests to see if State2 is ok
%    solve(State2, ..., Solution).
%

solve(State, RevSolution, Solution) :-
   final_state(State),
   show_moves(RevSolution),
   reverse(RevSolution, Solution),
   !.
solve(StateIn, Path, Solution) :-
   show_moves(Path),
   move(StateIn, StateOut, Move),
   not unsafe(StateOut),
   not member(StateOut, Path),
   solve(StateOut, [StateOut, Move | Path], Solution).

show_moves(Path) :-
   reverse(Path, RPath),
   show_moves2(RPath).
   
show_moves2([]) :-
   nl,
   !.
show_moves2([move(T,X)|Path]) :-
   write(move(T,X)),
   tab(1),
   !,
   show_moves2(Path).
show_moves2([_|Path]) :-
   !,
   show_moves2(Path).

%--------------------------------------------------
% Main
%
% And finally main/0 to get it all started.
%
% ?- main.
%

main :-
   initial_state( Start ),
   solve( Start, [Start], Solution ),
   nl,
   write_list(Solution, '\n'),
   nl, nl,
   fail.  % find all solutions
main.

stringize([], []).
stringize([S|X], [S|Y]) :- string(S), stringize(X,Y).
stringize([pour(J1,J2) | X], [S|Y]) :-
   output_string( [`pour `, J1, ` into `, J2], S ),
   stringize(X, Y).
stringize([T|X], [S|Y]) :- string_term(S, T), stringize(X,Y).

output_string( ListOfTerms, String ) :-
   stringize(ListOfTerms, StringList),
   stringlist_concat(StringList, String).


