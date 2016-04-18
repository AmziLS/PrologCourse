% breadth first with difference lists

% The previous breadth first example makes
% heavy use of append, which is an inefficient
% way to tack something onto the end of a
% long list.
%
% Difference lists let us keep track of the
% tail of a list and to 'append' the new
% list in a length of time related only
% to the length of the new list.

path(FROM, TO, PATH) :-
   bpath(FROM, TO, RPATH),
   reverse(RPATH, PATH).

bpath(FROM, TO, PATH) :-
   bpath2(TO, [[FROM]|Z]-Z, PATH).

bpath2(_, []-[], _) :- !, fail.
bpath2(TO, [[TO|PATH]|_]-_, [TO|PATH]).
bpath2(TO, [[X|P1]|REST]-Z, PATH) :-
   TO \= X,
   expand_path([[X|P1]|REST]-Z, NEWREST),
   bpath2(TO, NEWREST, PATH).
bpath2(TO, [[TO|P1]|REST]-Z, PATH) :-
   bpath2(TO, REST-Z, PATH).

expand_path([[X|P1]|REST]-Z, NEWREST) :-
   findall([TO,X|P1],
      ( flight(X,TO),
        not member(TO,P1) ),
      NEXTS),
   add_on(NEXTS, REST-Z, NEWREST).

add_on([], Z, Z).
add_on([X|Y], REST-[X|Z], NEWREST) :-
   add_on(Y, REST-Z, NEWREST).


