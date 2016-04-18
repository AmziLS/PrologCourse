/* depth first search.

  The path will be built from the start to the finish,
  and is seeded using the start (FROM).  Each new
  node is added to the head of the list, so the when
  the list is finished, it is reversed.

  Concepts - accumulators, the SOFAR argument
  */


path(FROM, TO, PATH) :-
   path(FROM, TO, [FROM], RPATH),
   reverse(RPATH, PATH).

path(FROM, TO, SOFAR, [TO|SOFAR]) :-
   flight(FROM, TO).
path(FROM, TO, SOFAR, PATH) :-
   flight(FROM, X),
   X \= TO,
   not member(X, SOFAR),
   path(X, TO, [X|SOFAR], PATH).