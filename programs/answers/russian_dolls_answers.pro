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

a_test( a(a(a(a))) ).

% a_count(A,N)
% counts the elements in a doll

a_count(A,N) :-
   a_count3(A,1,N).

a_count3(a,N,N).
a_count3(a(A),ACC,N) :-
   ACC2 is ACC + 1,
   a_count3(A,ACC2,N).

a_nest(a(A), A).

% create a doll nested N deep

a_build(1, a).
a_build(N, a(A)) :-
  N > 1,
  NN is N - 1,
  a_build(NN, A).

% A Greek doll is just like a Russian doll,
% but is represented by a b.  Copy a Russian
% doll to a Greek one.

ab_copy(a, b).
ab_copy(a(A), b(B)) :-
  ab_copy(A,B).

% a doll with a prize inside

a_hide(0, FINISHED_DOLL, FINISHED_DOLL).
a_hide(N, SOFAR, A) :-
  N > 0,
  NN is N - 1,
  a_hide(NN, a(SOFAR), A).

a_prize(X, X) :-
   X \= a(_).
a_prize(a(A), P) :-
   a_prize(A, P).

%--------------------------------
% Open Russian Dolls
%

a_open_build(1, a(X)-X).
a_open_build(N, a(A)-X) :-
  N > 1,
  NN is N - 1,
  a_open_build(NN, A-X).

a_open_hide(A-P, P).

a_open_prize(A-P, P).

%------------------------------------
% Turkish Dolls
%

c_test( c(b1, c(b2, c(b3, c))) ).

c_length(C, N) :-
  c_length3(C, 0, N).

c_length3(c, N, N).
c_length3(c(_,T), ACC, N) :-
  ACC2 is ACC + 1,
  c_length3(T, ACC2, N).

c_write(c) :- nl.
c_write(c(H,T)) :-
  write(H), tab(1),
  c_write(T).

c_member(H, c(H,_)).
c_member(H, c(_,T)) :-
  c_member(H, T).

c_reverse(C, CR) :-
  c_reverse3(C, c, CR).

c_reverse3(c, CR, CR).
c_reverse3(c(H,T), ACC, CR) :-
  c_reverse3(T, c(H,ACC), CR).

c_append(c, C, C).
c_append(c(H,X), Y, c(H,Z)) :-
  c_append(X, Y, Z).

%-------------------------------------
% Romanian Dolls
%

d_test( d(apple,L1,d(pear,d(cherry,L2,R2),d(plum,L3,R3))) ).

d_write(X) :- var(X), !.
d_write(d(X,LEFT,RIGHT)) :-
  d_write(LEFT),
  write(X), nl,
  d_write(RIGHT).

d_loop(D) :-
  write('item? '), read(ITEM),
  d_store(ITEM, D),
  ITEM \= quit,
  d_loop(D).
d_loop(D).

d_store(X, d(X,_,_)) :- !.
d_store(X, d(Y,LEFT,_)) :-
  X @< Y,
  d_store(X, LEFT).
d_store(X, d(Y,_,RIGHT)) :-
  X @> Y,
  d_store(X, RIGHT).

