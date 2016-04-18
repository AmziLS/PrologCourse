% frames.pro
%
% a library of frame predicates.
%

:- ensure_loaded(list).
:- import(list).

%--------------------------------------------
% create_frame(Class, Instance)
% creates a new frame of a given class and instance.
%

create_frame(Class, Instance) :-
   F =.. [Class, Instance, []],
   assert(F).

%--------------------------------------------
% frame(Class, Instance, Properties)
%

frame(Class, Instance, Properties) :-
   F =.. [Class, Instance, Properties],
   call(F).

%------------------------------------------------
% add_property(Class, Instance, Property)
% adds a new property to an existing frame instance.
%

add_property(Class, Instance, Property) :-
   F =.. [Class, Instance, PropertyList],
   retract(F),
   F2 =.. [Class, Instance, [Property|PropertyList]],
   assert(F2).

%------------------------------------------------
% remove_property(Class, Instance, Property)
% adds a new property to an existing frame instance.
%

remove_property(Class, Instance, Property) :-
   F =.. [Class, Instance, PropertyList],
   retract(F),
   delete(Property, PropertyList, PropertyList2),
   F2 =.. [Class, Instance, PropertyList2],
   assert(F2).

%--------------------------------------------------
% match( Test, PropertyList )
%
% match/2, like member/2, can test if a property = value
% is on a property list, but can also test for other
% conditions, such as X > 3.
%

match( Test, [Prop | Props] ) :-
   test(Test, Prop).
match( Test, [_ | Props] ) :-
   match( Test, Props ).

/*
test( P = V, P = V ) :-
   !.
test( P > X, P = V ) :-
   V > X,
   !.
test( P < X, P = V ) :-
   V < X,
   !.
test( P >= X, P = V ) :-
   V >= X,
   !.
test( P =< X, P = V ) :-
   V =< X,
   !.
*/

test( PX, P = V ) :-
   PX =.. [OP, P, X],
   member(OP, [=, >, <, >=, =<, @>=, @>, @<, @=<, \=]),
   VX =.. [OP, V, X],
   call(VX),
   !.

% ?- pl(X, PL), match( not wheels > 4, PL )
% X = (all except two and five)

test( includes(P,V), P = List ) :-
   member(V, List).
test( count(P,L), P = List ) :-
   length(List, L).
test( not Test, P = V ) :-
   Test =.. [Op, P | Args], 
   not test(Test, P = V).
test( P = X, P = List ) :-
   list(List),
   member(X, List).

%-------------------------------------------
% If the application declares transitive
% properties, then use them.
%
% transitive(word, kind_of).
% transitive(word, contains).
%

test( P = X, P = V ) :-
   transitive(Class, P),
   not list(V),
   frame(Class, V, Props),
   match(P = X, Props).
test( P = X, P = Vs ) :-
   transitive(Class, P),
   list(Vs),
   member(V, Vs),
   frame(Class, V, Props),
   match(P = X, Props).

test(X, X).

%-----------------------------------------------
% match_list(TestList, PropertyList)
%
% matches a list of tests against a property list
%

match_list( [], _ ).
match_list( [Test|Tests], Properties) :-
   match(Test, Properties),
   match_list(Tests, Properties).



%--------------------------------------------
% find_frame(Class, Instance, Query).
%
% ?- find_frame(word, W, shape=disc).
% W = pizza ;
% W = frisbee ;
% no
%
% ?- find_frame(pl, PL, [color=blue, wheels>2]).
% PL = one ;
% PL = seven ;
% no

find_frame(Class, Instance, Query) :-
   F =.. [Class, Instance, Properties],
   call(F),
   ( list(Query) ->
        match_list(Query, Properties)
        ;
        match(Query, Properties) ).

%-------------------------------------------------
% add transitivity for certain frame/properties
% add frame/3 that gets a specific frame by its instance

% ?- find_frame(word, kind_of = life_form, orange).
% yes

% ?- find_frame(word, kind_of = life_form, X).
% X = orange ;
% X = tree ;
% X = plant ;
% no

% ?- find_frame(word, contains = tomatoes, X).
% X = pizza ;
% X = tomato_sauce ;
% no
