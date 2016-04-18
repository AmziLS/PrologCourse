%-------------------------------------
% Exercises in lists and recursion.

%-------------------------------------
% length(List, Len)
%
% ?- length([a,b,c], X).
% X = 3;
% no
%

length(L, N) :-
   length(L, 0, N).

length([], N, N).
length([_|T], Acc, N) :-
   Next is Acc + 1,
   length(T, Next, N).

%------------------------------------
% member(Item, List)
%
% ?- member(X, [a,b,c]).
% X = a;
% X = b;
% X = c;
% no
%

member(A, [A|_]).
member(A, [_|Z]) :-
   member(A, Z).

%-------------------------------------
% append(List1, List2, List12)
%
% ?- append([a,b,c], [d,e,f], X).
% X = [a,b,c,d,e,f];
% no
% ?- append(X, Y, [a,b,c]).
% X = []
% Y = [a,b,c];
% X = [a]
% Y = [b,c];
% ...
%

append([], X, X).
append([A|X], Y, [A|Z]) :-
   append(X,Y,Z).


%------------------------------------------
% reverse(List, ReversedList)
%
% ?- reverse([a,b,c], X).
% X = [c,b,a]
%

reverse(X, Y) :-
   reverse(X, [], Y).
   
reverse([], Y, Y).

reverse([A|Z], SoFar, X) :-
   reverse(Z, [A|SoFar], X).

%--------------------------------------
% sum(ListOfNumbers, Sum)
%
% ?- sum([1,2,3], X).
% X = 6;
% no
%
% use accumulator, like length/2
%

%--------------------------------------
% write_list(List)
%
% writes each element on a different line
%
% ?- write_list([a,b,c]).
% a
% b
% c
%
% walks the list like member/2

%---------------------------------------
% write_list(List, Separator)
%
% writes the list with separator of your choice
%
% ?- write_list([a,b,c], ', ').
% a, b, c
%
% Don't write the separator after the last item!
%
   
%-----------------------------------------
% last(List, LastItem)
%
% ?- last([a,b,c], X).
% X = c
%

%---------------------------------------
% triplets(List, Triplet)
% see if there's three in a row of something
%
% ?- triplets([a,a,b,b,b,c,d], X).
% X = b
%

%---------------------------------------
% double(List, DoubledList)
% double all the numbers in a numeric list
%
% ?- double([1,2,3], X).
% X = [2,4,6]
%

%--------------------------------------
% extract_numbers(List, NumberList)
% just take the elements that are numbers.
%
% ?- extract_numbers( [a, 1, b, c, 3], X ).
% X = [1, 3]
%
% use the built-in number(X) to test if an element is a number.
% there will be two recursive clauses, one for each case.
% ?- number(3).
% yes
% ?- number(a).
% no.

%---------------------------------------
% delete(Item, List, NewList)
% delete an item from a list, return the list without i
%
% ?- delete(b, [a,b,c,b,d], X).
% X = [a,c,b,d];
% no
%
% a little like member, the boundary condition
% is when you can easily delete the item.
%

%----------------------------------------
% delete_all(Item, List, NewList)
%
% ?- delete(b, [a,b,c,b,d], X).
% X = [a,c,d]
%

%------------------------------------------
% remove_dups(ListWithDups, ListWithout)
%
% ?- remove_dups([a,b,c,b,c,b,a], X).
% X = [a,b,c]
%

%-------------------------------------------
% nth_item(N, List, NthItem)
%
% ?- nth_item(3, [a,b,c,d], X).
% X = c
%

%------------------------------------------
% insert(Item, N, ListBefore, ListAfter)
%
% ?- insert(w, 3, [a,b,c,d], X).
% X = [a,b,w,c,d]
%

%-------------------------------------------
% insert(Item, ListBefore, ListAfter)
% inserts in sort order in sorted list
%
% ?- insert(b2, [a,b,c,d], X).
% X = [a,b,b2,c,d]
%

%----------------------------------------------
% flatten(BumpyList, FlatList).
%
% ?- flatten([a, b, [c, d, [], e, ], [f, [g], h]], X).
% X = [a,b,c,d,e,f,g,h].
%
% This one is hard.
%
% END OF FIRST LIST EXERCISES
%----------------------------------------------

%----------------------------------------------
% SET PREDICATES
%
% using the above predicates as needed, and
% using lists to represent sets, write:
%
% make_set(List, Set).
% where a set is just sorted list. (use sort/2)
%
% ?- make_set([b,c,a], X).
% X = [a,b,c].
%

%------------------------------------------
% intersection(S1, S2, Intersection)
% 
% ?- intersection([a, b, c], [b, c, d, e], X).
% X = [b, c].
%
% HINT: use member to find common items in each
%


%--------------------------------------------
% subset(Subset, Superset)
%
% ?- subset([b, c, e], [a, b, c, d, e, f]).
% yes
% ?- subset([b, c, e], [a, b, c, d, f]).
% no
%

%-------------------------------------------
% union(S1, S2, Union)
% 
% ?- union([a, b, c], [b, c, d], X).
% X = [a, b, c, d]
%
% HINT: append and remove duplicates
%