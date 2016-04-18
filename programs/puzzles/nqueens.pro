% This program finds a solution to the 8 queens problem.  That is, the problem of placing 8
% queens on an 8x8 chessboard so that no two queens attack each other.  The prototype
% board is passed in as a list with the rows instantiated from 1 to 8, and a corresponding
% variable for each column.  The Prolog program instantiates those column variables as it
%  finds the solution.
 
% Programmed by Ron Danielson, from an idea by Ivan Bratko. 

% to use it:
% ?- board(X), queens(X).
% use ; to see all the solutions.
 
queens([]).
 
queens([ Row/Col | Rest]) :-
            queens(Rest),
            member(Col, [1,2,3,4,5,6,7,8]),
            safe( Row/Col, Rest).
 
safe(Anything, []).
 
safe(Row/Col, [Row1/Col1 | Rest]) :- 
            Col =\= Col1,
            Col1 - Col =\= Row1 - Row,
            Col1 - Col =\= Row - Row1,
            safe(Row/Col, Rest).
 
member(X, [X | Tail]).
 
member(X, [Head | Tail]) :-
            member(X, Tail).
 
board([1/C1, 2/C2, 3/C3, 4/C4, 5/C5, 6/C6, 7/C7, 8/C8]).     % prototype board