% Exercises in lists and recursion.

%-------------------------------------
% length(List, Len)
%
% ?- length([a,b,c], X).
% X = 3;
% no
%

length(L, X) :-
  length(L, 0, X).

length([], N, N).
length([_|Z], SoFar, N) :-
  SoFar2 is SoFar + 1,
  length(Z, SoFar2, N).

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
  member(A,Z).

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

append([], Z, Z).
append([A|X], Y, [A|Z]) :-
  append(X, Y, Z).

%--------------------------------------
% sum(ListOfNumbers, Sum)
%
% ?- sum([1,2,3], X).
% X = 6;
% no
%
% use accumulator, like length/2
%

sum(L, V) :-
   sum(L, 0, V).

sum([], V, V).
sum([A|Z], SoFar, V) :-
   Next is SoFar + A,
   sum(Z, Next, V).
   
sumr([A|Z], V) :-
   sumr(Z, A, V).

sumr([], E, V) :-
   V is E.
sumr([A|Z], SoFar, V) :-
   sumr(Z, SoFar + A, V).
   
sum2([], 0).
sum2([A|Z], N) :-
   sum2(Z,NN),
   N is NN + A.
   
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

write_list([]).
write_list([A|Z]) :-
  write(A),
  nl,
  write_list(Z).

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

write_list([X], _) :-
   write(X),
   nl,
   !.
write_list([A|Z], S) :-
   write(A),
   write(S),
   write_list(Z, S).

testwl :- write_list([a,b,c], ', '), fail.

%-----------------------------------------
% last(List, LastItem)
%
% ?- last([a,b,c], X).
% X = c
%

last([X], X).
last([_|Z], X) :-
  last(Z, X).

%---------------------------------------
% triplets(List, Triplet)
% see if there's three in a row of something
%
% ?- triplets([a,a,b,b,b,c,d], X).
% X = b
%

triplets([X,X,X|_], X).
triplets([_|Z], X) :-
  triplets(Z, X).

%---------------------------------------
% double(List, DoubledList)
% double all the numbers in a numeric list
%
% ?- double([1,2,3], X).
% X = [2,4,6]
%

dbl([], []).
dbl([A|X], [B|Y]) :-
   B is 2 * A,
   dbl(X, Y).

dox(L1, L2) :-
  catch( dox2(L1,L2), E, write(E)).
  
dox2(L1, L2) :-
  catch( x2(L1,L2), x2_error(E), process_error(E)).

process_error(E) :-
  write('X2 Error: '),
  write(E),
  nl,
  fail.

x2([], []).
x2([A|X], [B|Y]) :-
%   ( (not number(A)) ->
%       throw(x2_error(not_number(A)))
%       ;
%       true ),
   B is 2 * A,
   x2(X, Y).

%--------------------------------------
% sum_pairs(List, ListOfSummedPairs)
%
% ?- sum_pairs([1,2,3,4,5,6], X).
% X = [3,7,11].
%

sum_pairs([], []).
sum_pairs([A,B | X], [C|Y]) :-
   C is A + B,
   sum_pairs(X, Y).
   
   
%--------------------------------------
% multiply(List, N, MultipliedList)
% multiply all the numbers by N
%
% ?- multiply([1,2,3], 3, X).
% X = [3,6,9]
%

mult([], _, []).
mult([A|X], N, [B|Y]) :-
   B is A * N,
   mult(X, N, Y).
   

%---------------------------------------
% apply(List, X:Y:Goal, NewList)
% applies the predicate to X in the first list
% and puts Y in the new list
%
% ?- apply([1,2,3], X:Y:Y is X**2, L).
% L = [1,4,9].
%
% Oh so clever Prolog sort of thing,
% use call on the Goal
%
% ?- apply([sue, bob], f(X,Y,likes(X,Y)), L).
% L = [bill, sally]   % or whatever it was....
%

translate(one, uno).
translate(two, dos).
translate(three, tres).
translate(cow, vaca).
translate(E, S) :-
   atom_chars(E, Es),
   reverse(Es, REs),
   reverse([o|REs], Ss),
   atom_chars(S, Ss).

apply([], _, []).
apply([A|Y], F, [B|Z]) :-
  dof(A,B,F),
  apply(Y, F, Z).

dof(A,B, F) :-
  copy_term(F, f(A,B,Fab)),
  call(Fab).
  
%---------------------------------------
% delete(Item, List, NewList)
%
% ?- delete(b, [a,b,c,b,d], X).
% X = [a,c,b,d];
% no
%
% a little like member, the boundary condition
% is when you can easily delete the item.
%

delete(A, [A|Z], Z).
delete(A, [B|Y], [B|Z]) :-
   delete(A, Y, Z).

%----------------------------------------
% delete_all(Item, List, NewList)
%
% ?- delete(b, [a,b,c,b,d], X).
% X = [a,c,d]
%

delete_all(_, [], []).
delete_all(A, [A|Z], W) :-
   !, delete_all(A, Z, W).
delete_all(A, [B|Y], [B|Z]) :-
   !, delete_all(A, Y, Z).

%------------------------------------------
% remove_dups(ListWithDups, ListWithout)
%
% ?- remove_dups([a,b,c,b,c,b,a], X).
% X = [a,b,c]
%

remove_dups([], []).
remove_dups([A|X], [A|Y]) :-
   delete_all(A,X,W),
   !,
   remove_dups(W,Y).

%------------------------------------------
% Sets are sorted lists with no duplicates.
%
% write three set predicates:
% 
% list_set(List, Set).  - converts a list to a set
% union(S1, S2, U) - U in the union of sets S1 and S2
% intersection(S1, S2, I) - I is the intersection of sets S1 and Sw
%

list_set(L, S) :-
   sort(L, LSorted),
   remove_dups(LSorted, S).
   
intersection(S1, S2, Int) :-
   findall(X, (member(X,S1), member(X,S2)), Int).

union(S1, S2, Union) :-
   append(S1, S2, App),
   remove_dups(App, Union).


%------------------------------------------
% reverse(List, ReversedList)
%
% ?- reverse([a,b,c], X).
% X = [c,b,a]
%

nreverse([], []).
nreverse([A|X], Z) :-
   nreverse(X, R),
   append(R, [A], Z).

reverse(X,Y) :-
  reverse(X, [], Y).
  
reverse([],Z,Z).
reverse([A|X], SoFar, Z) :-
  reverse(X, [A|SoFar], Z).

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
