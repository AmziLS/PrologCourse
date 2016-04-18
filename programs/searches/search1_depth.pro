% depth first search.

% The path will be built from the start to the finish.
% The accumulator is seeded with [FROM].  Each level
% of recursion adds a new head to the accumulated list,
% so when the accumulated list gets to the boundary
% condition, it is reversed, that is TO is first and
% FROM is last.

% The accumulated path serves a dual purpose. In addition
% to keeping track of where we've been, it lets us make
% sure that we don't go in a loop, so before jumping
% to a new airport, member/2 is used to check that
% we haven't been there before.

path(FROM, TO, PATH) :-
   path(FROM, TO, [FROM], RPATH),
   reverse(RPATH, PATH).

path(FROM, TO, SOFAR, [TO|SOFAR]) :-
   flight(FROM, TO).
path(FROM, TO, SOFAR, PATH) :-
   flight(FROM, X),
   X \= TO,
   not check_member(X, SOFAR),
   path(X, TO, [X|SOFAR], PATH).