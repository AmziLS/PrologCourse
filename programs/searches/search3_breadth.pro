% breadth first search

% The accumulator is a list of partial path lists.
% That is, each element in the accumulated list is
% itself a list of a started path.

% On each loop through the recursion:
%
% If the path ends (the list is reversed, so the head
% of the list is the last point visited) with the TO
% desired destination, then we've found a path.
%
% If the path doesn't end where we want, then it is
% removed from the head of the list.  A new list of
% partial paths is constructed from that list, with
% one more hop on each.  That new list is appended to
% the end of the list of candidate paths.
%
% And, seeing as we're looking for all paths, if we
% want to continue after finding a path, we simply
% drop the successful path and continue with the
% next one.

path(FROM, TO, PATH) :-
   bpath(FROM, TO, RPATH),
   reverse(RPATH, PATH).

bpath(FROM, TO, PATH) :-
   bpath2(TO, [[FROM]], PATH).

bpath2(TO, [[TO|PATH]|REST], [TO|PATH]).
bpath2(TO, [[X|P1]|REST], PATH) :-
   TO \= X,
   expand_path([[X|P1]|REST], NEWREST),
   bpath2(TO, NEWREST, PATH).
bpath2(TO, [[TO|P1]|REST], PATH) :-
   bpath2(TO, REST, PATH).

expand_path([[X|P1]|REST], NEWREST) :-
   findall([TO,X|P1],
      ( flight(X,TO),
        not member(TO,P1) ),
      NEXTS),
   append(REST, NEXTS, NEWREST).
