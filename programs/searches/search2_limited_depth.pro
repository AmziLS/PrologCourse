% limited depth first search

% path is set to succeed only if the depth is exactly
% what was called for.  dig_paths tries first with
% depth = 1, and then finds paths for 2, etc.

maxdepth(3).

path(FROM, TO, PATH) :-
   dig_paths(FROM, TO, 1, RPATH),
   reverse(RPATH, PATH).

dig_paths(FROM, TO, DEPTH, RPATH) :-
   maxdepth(MAXD),
   DEPTH =< MAXD,
   path(FROM, TO, DEPTH, [FROM], RPATH).
dig_paths(FROM, TO, DEPTH, RPATH) :-
   maxdepth(MAXD),
   DEPTH =< MAXD,
   D2 is DEPTH + 1,
   dig_paths(FROM, TO, D2, RPATH).

path(FROM, TO, DEPTH, SOFAR, [TO|SOFAR]) :-
   DEPTH = 1,
   flight(FROM, TO).
path(FROM, TO, DEPTH, SOFAR, PATH) :-
   DEPTH > 0,
   flight(FROM, X),
   X \= TO,
   not check_member(X, SOFAR),
   D2 is DEPTH - 1,
   path(X, TO, D2, [X|SOFAR], PATH).

