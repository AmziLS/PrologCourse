member(A, [A|_]).
member(A, [_|Y]) :- member(A,Y).

check_member(A, [A|_]) :- !.
check_member(A, [_|Y]) :- check_member(A,Y).

append([], Z, Z).
append([A|X], Y, [A|Z]) :- append(X,Y,Z).

reverse(X, Y) :- reverse(X, [], Y).

reverse([], Y, Y).
reverse([A|X], ACC, Y) :- reverse(X, [A|ACC], Y).