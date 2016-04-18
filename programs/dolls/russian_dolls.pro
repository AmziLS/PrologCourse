% Russian Dolls exercises
%
% Russian dolls are the ones that nest within each
% other.  At the end is a wooden doll.
%
% A Russian doll that can hold another is represented
% for these exercises as a(_).  So it is a structure,
% a/1.  The wooden doll is represented by just the
% atom a.  For example, a triple nested doll is:
%
%   a(a(a(a)))

% a test doll.
% ?- a_test(X).
% X = a(a(a(a)))

a_test( a(a(a(a))) ).

% ---------------------------------------
% NOTE - the +A, -N description is often used
% to document which is input and which is output
%
% a_count(+A,-N)
%   A - the input doll
%   N - the output count
% hint: use an accumulator and a second
%   predicate a_count/3.  the boundary
%   condition will be the wooden doll
% 
% ?- a_count(a, N).
% N = 1 
% yes
% 
% ?- a_test(A), a_count(A,N).
% A = a(a(a(a)))
% N = 4 
% yes
%



% ---------------------------------------
% a_nest(?A1, ?A2)
%   A1 - the outer nested dolls
%   A2 - the inner nested dolls
% hint: this is done with a simple fact
%   that does it work through unification.
% 
% ?- a_test(A), a_nest(A, A2).
% A = a(a(a(a)))
% A2 = a(a(a)) 
% yes
% 
% ?- a_test(A), a_nest(A2, A).
% A = a(a(a(a)))
% A2 = a(a(a(a(a)))) 
% yes
% 




% ---------------------------------------
% a_build(+N, -A)
%   N - the number of levels of nesting.
%   A - the output doll, nested N deep.
% hint: do not use an accumulator.  boundary
%   condition is when count is 1, and the
%   answer then is the wooden doll.  recursive
%   calls recurse to fill in building structure.
% 
% ?- a_build(1,A).
% A = a 
% yes
% 
% ?- a_build(5,A).
% A = a(a(a(a(a)))) 
% yes
% 



% ---------------------------------------
% A Greek doll is just like a Russian doll,
% but is represented by the letter b.  This
% predicate makes a Greek copy to the
% same level of nesting as an input Russian
% doll.
% 
% ab_copy(?A, ?B)
%   A - a Russian doll, either input or out.
%   B - a Greek doll, either output or in.
% hint: simple recursion, no tricks.
% 
% ?- a_test(A), ab_copy(A,B).
% A = a(a(a(a)))
% B = b(b(b(b))) 
% yes
% 




% ---------------------------------------
% TURKISH DOLLS
% 
% Turkish dolls are like Russian dolls, except
% they have two compartments.  In the left-hand
% one there can be anything, like an apple, pear,
% plum, or cherry.  The right is a special
% compartment that can only hold another turkish
% doll.
% 
% There is a wooden Turkish doll for the right
% side when there is no more nesting.
% 
% A Turkish doll is represent by the structure
% c/2.  The wooden doll is represented by c.
% Here is a nested turkish doll with four
% fruits in it.
% 
% c(apple, c(pear, c(plum, c(cherry, c))))
% 
% ---------------------------------------
% c_test(-C)
%   C - a test doll from above.
% 
% ?- c_test(C).
% C = c(apple,c(pear,c(plum,c(cherry,c)))) 
% yes
% 

c_test( c(apple, c(pear, c(plum, c(cherry, c)))) ).

% ---------------------------------------
% c_length(+C, -L)
%   C - the input doll
%   L - the number of items in the doll
% hint: use an accumulator.  the boundary condition
%   is the wooden doll, c.
% 
% note: for most of the following examples, the
%   bindings for C from c_test is omitted from
%   the sample output.
% 
% ?- c_test(C), c_length(C,L).
% L = 4 
% yes
% 



% ---------------------------------------
% c_write(+C)
%   C - the input doll, whose things are
%     to be written out.
% hint: keep writing what you see and
%   recursing with what's left.
% 
% ?- c_test(C), c_write(C).
% apple pear plum cherry 
% yes
% 



% ---------------------------------------
% c_member(?ITEM, +C)
%   ITEM - an item to look for, or variable
%     which will take the value of items
%     found.
%   C - the input doll.
% 
% note: c_member can test if something
%   is in a doll:
% 
% ?- c_test(C), c_member(pear, C).
% yes
% 
% note: or generate on backtracking all
%   of the items in a doll:
% 
% ?- c_test(C), c_member(X,C).
% X = apple ;
% X = pear ;
% X = plum ;
% X = cherry ;
% no
% 



% ---------------------------------------
% c_reverse(+C, -CR)
%   C - an input doll
%   CR - an output doll, with items in
%     reverse order
% hint: call c_reverse/3 and use an accumulator
%   to build the
%   output doll, it will be automatically
%   reversed when it gets to the boundary
%   condition.
% 
% ?- c_test(C), c_reverse(C, CR).
% C = c(apple,c(pear,c(plum,c(cherry,c))))
% CR = c(cherry,c(plum,c(pear,c(apple,c)))) 
% yes
% 

c_reverse(C, CR) :-
   c_reverse(C, c, CR).
   


%
% END FIRST EXERCISES
%------------------------------------

%------------------------------------
% Open structure exercises
%
%---------------------------------------
% We don't have to put the wooden
% doll in as the last thing.  How about if
% we can hide anything we want in the
% inner-most doll?
% 
% a_hide(+N, +PRIZE, -A)
%   N - the number of nested dolls
%   PRIZE - the thing in the middle
%   A - the output doll
% hint: this might look like a_build, but
%   isn't.  you need an accumulator that
%   starts with the prize and wraps layers
%   as it goes down.  but note that the
%   second argument is that accumulator,
%   seeded with the prize.
% 
% ?- a_hide(3, plum, A).
% A = a(a(a(plum))) 
% yes
% 
% note: when called with nesting of 0,
%   there are no dolls, just the prize.
% 
% ?- a_hide(0, plum, A).
% A = plum 
% yes
% 
% test: is it covered against run-away
%   behavior on backtracking?
% 
% ?- a_hide(3, plum, A).
% A = a(a(a(plum))) ;
% no
% 



% ---------------------------------------
% a_prize(+A, -PRIZE)
%   A - some input doll
%   PRIZE- the thing hidden in the middle
% hint: keep peeling off layers and let the
%   next call down find the prize.  the boundary
%   condition is when A is not a doll, or when
%   A \= a(_).
% 
% ?- a_hide(3, plum, A), a_prize(A, PRIZE).
% A = a(a(a(plum)))
% PRIZE = plum 
% yes
% 



% ---------------------------------------
% OPEN DOLLS
% 
% With the dolls so far, we need to dig to
% find the prize.  What if we were to keep
% open a shortcut to the inside?  We could
% then access the inside directly.
% 
% We do this by having two related terms, one
% being the full doll, and the other being
% the inside of the doll.  For example:
% 
% a(a(a(plum)))-plum
% 
% With this structure, we can get the plum
% directly, or peel the layers, as we please.
% 
% If we build an open doll with a variable
% inside, then we can just unify that variable
% and fill the doll at the same time.  So if
% we had
% 
% a(a(a(X)))-X
% 
% by setting X = plum, we also put plum in the
% middle of the doll.
% 
% Here's some predicates that illustrate this
% point, using 'open structures', or structures
% with a variable in them to begin with.
% 
% ---------------------------------------
% a_open_build(+N, -OA)
%   N - the input level of nesting
%   OA - the open Russian doll
% hint: similar to a_build, but the
%   boundary condition is when N = 1,
%   and the doll is a(X)-X.
% note: this is the hardest of the open
%   doll predicates to figure out.
% 
% ?- a_open_build(3, A).
% A = a(a(a(H53))) - H53 
% yes
% 



% ---------------------------------------
% a_open_hide(?OA, +PRIZE)
%   OA - an input open doll, prefaced with?
%     because, although input, it is changed
%     when its inner variable is unified.
%   PRIZE - the thing to put inside.
% hint: a simple fact that does the
%   work with unification.
% 
% ?- a_open_build(3,A), a_open_hide(A,plum).
% A = a(a(a(plum))) - plum 
% yes
% 
% note: once you've put something in the open doll
%   you can't put a different thing in:
% 
% ?- a_open_build(3,A),a_open_hide(A,plum),a_open_hide(A,peach).
% no
% 



% ---------------------------------------
% a_open_prize(+OA, -PRIZE)
%   OA - an input open doll, probably
%     with its inner prize unified.
%   PRIZE - the thing found inside.
% hint: the same predicate as a_open_hide.
% 
% ?- a_open_build(3,A),a_open_hide(A,plum),a_open_prize(A,P).
% A = a(a(a(plum))) - plum
% P = plum 
% yes


%---------------------------------------
% ROMANIAN DOLLS
% 
% Romanian dolls are like Turkish dolls, except
% they have three compartments.  The first is
% for whatever thing might be there.  The second
% and third are both Romanian dolls.  The second
% might have things less than the thing, and
% the third might have things more than the thing.
% 
% In other words, a tree structure.  If the nodes
% are left as variables, that is, open, then they
% can be filled in later.
% 
% So for example this structure
% 
%   d(apple,L1,d(pear,d(cherry,L2,R2),d(plum,L3,R3)))
% 
% is the tree:
% 
%           apple
%          /     \
%         ?     pear
%              /    \
%         cherry    plum
%        /   \      /   \
%       ?     ?    ?     ?
% 
% The ? are open variables, that can be filled in
% (unified) with new branches of the tree.
% 
% ---------------------------------------
% d_test(-D)
%   D - a test tree, the one above.
% 
% ?- d_test(D).
% D = d(apple,H35,d(pear,d(cherry,H43,H44),d(plum,H47,H48))) 
% yes
% 




% ---------------------------------------
% d_write(+D)
%   D - a tree to display left to right
% hint: if the tree is a variable, then that's the
%   end of a branch.  to test if X is a variable,
%   use the built-in predicate var(X).  the recursive
%   case writes out the left side first, then the
%   thing, then the right side.
% 
% ?- d_test(D), d_write(D).
% apple
% cherry
% pear
% plum
% D = d(apple,H43,d(pear,d(cherry,H51,H52),d(plum,H55,H56))) 
% yes
% 




% ---------------------------------------
% d_store(+ITEM, ?D)
%   ITEM - a thing to put in the tree, in alphabetical
%     sequence.
%   D - a growing open tree
% hint: the boundary condition simply creates a new
%   tree node, with the item as the thing in the node.
%   there are two recursive cases, depending on whether
%   the item sorts higher or less than the thing in the
%   node being examined.  use @< and @> to compare an
%   item with the thing in the current node.
% note: make sure you put a ! in the boundary case,
%   to stop it from going wild unifying variables with
%   variables ad infinitum on backtracking.
% 
% test: this loop should get values from the user and
%   store them in the tree, which is just a variable
%   to start.
% 
% d_loop(D) :-
%   write('item? '), read(ITEM),
%   d_store(ITEM, D),
%   ITEM \= quit,
%   d_loop(D).
% d_loop(D).
% 
% ?- d_loop(D), d_write(D).
% item? apple.
% item? pear.
% item? plum.
% item? cherry.
% item? quit.
% apple
% cherry
% pear
% plum
% D = d(apple,H89,d(pear,d(cherry,H480,H481),d(plum,H336,H337))) 
% yes
% 



% ---------------------------------------

