% best first search

% See bratko for discussion on this, although
% he uses trees, not lists, and I must confess
% I didn't get his example to work for me.
%
% Best first (A*) search is like the breadth
% first search, but it uses a guesstimate of
% the cost of each candidate path to sort
% the candidate paths.  The best ones are
% used first.
%
% Note in this case there are some funny
% costs between cvg and tpa that makes for
% strange routings.


path(FROM, TO, COST-PATH) :-
   bpath(FROM, TO, COST-RPATH),
   reverse(RPATH, PATH).

bpath(FROM, TO, PATH) :-
   guess_cost(FROM, TO, COST),
   bpath2(TO, [COST-[FROM]], PATH).

bpath2(TO, [COST-[TO|PATH]|REST], COST-[TO|PATH]).
bpath2(TO, [COST-[X|P1]|REST], PATH) :-
   TO \= X,
   expand_path(TO, [COST-[X|P1]|REST], NEWREST),
   bpath2(TO, NEWREST, PATH).
bpath2(TO, [_-[TO|P1]|REST], PATH) :-
   bpath2(TO, REST, PATH).

expand_path(GOAL, [COST-[X|P1]|REST], NEWREST) :-
   findall([TO,X|P1],
      ( flight(X,TO),
        not member(TO,P1) ),
      NEXTS),
   figure_costs(NEXTS, GOAL, COSTED_NEXTS),
   append(COSTED_NEXTS, REST, COSTED_REST),
   keysort(COSTED_REST, NEWREST).

figure_costs([], _, []).
figure_costs([PATH|REST], GOAL, [COST-PATH|COSTED_REST]) :-
   figure_cost(PATH, GOAL, COST),
   figure_costs(REST, GOAL, COSTED_REST).

figure_cost([END|PATH], GOAL, COST) :-
   guess_cost(END, GOAL, GUESS),
   calc_cost([END|PATH], GUESS, COST).

calc_cost([_], TOTAL_COST, TOTAL_COST).
calc_cost([A,B|Z], SOFAR, TOTAL_COST) :-
   cost(B,A,COST),
   NEXT is SOFAR + COST,
   calc_cost([B|Z], NEXT, TOTAL_COST).

distance(A, B, DIST) :-
   city(A, _, Xa:Ya),
   city(B, _, Xb:Yb),
   DIST is integer( sqrt( (Xb-Xa)**2 + (Yb-Ya)**2 ) ).

cost(cvg,atl, COST) :-
   !, base_cost(cvg,atl,C1), COST is C1 * 25.
cost(cvg,bos, COST) :-
   !, base_cost(cvg,bos,COST).
cost(bos,tpa, COST) :-
   !, base_cost(bos,tpa,COST).
cost(A, B, COST) :-
   base_cost(A, B, C1),
   COST is 2 * C1.

guess_cost(A, B, COST) :-
   base_cost(A, B, COST).

base_cost(A, B, COST) :-
   distance(A, B, DIST),
   COST is 5 * DIST.
