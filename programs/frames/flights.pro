flt( f(usair101, 2005-10-28, 17:00, ft('HOU', 'CLT')) ).

get_from(F) :-
  flt( X ),
  arg( 4, X, FT ),
  arg( 1, FT, F ).
  

flight(usair-101,
   [ date = 2005-10-28,
     depart = 17:00,
     arrive = 19:00,
     carrier = 'US Air',
     from = 'HOU',
     to = 'CLT' ]).
flight(usair-102,
   [ date = 2005-10-28,
     depart = 20:00,
     arrive = 20:30,
     carrier = 'US Air',
     from = 'CLT',
     to = 'AVL' ]).
     
word('Charlotte',
   [ has_airport,
     airport_id = 'CLT' ]).
word('Houston',
   [ has_airport,
     airport_id = ['HOU', 'IAH'] ]).
word('Asheville',
   [ has_airport,
     airport_id = 'AVL' ]).
word('Hendersonville',
   [ has_airport,
     airport_id = 'AVL' ]).

person(joe,
   [from = 'Houston',
    to = 'Charlotte',
    date = 2005-10-28,
    depart @>= 17:00]).
person(dennis,
   [from = 'Houston',
    to = 'Asheville',
    date = 2005-10-28,
    depart @>= 17:00]).

% replace(AV, [AX|Z], [AV|Z])
%   AV = the new attribute value, ex.  color = blue or time @> 17:00
%   AX = the old attribute and value
% use =.. to get the operator and value

go :-
   person(X, Y),
   plan_trip(X, T),
   write(X:T), nl,
   fail.

% use the flight ontology to find the airport ids for the trip
% and replace to update the request list with those ids.  then
% call itinerary to actually plan the trip.
plan_trip( Person, Trip ) :-
   stub,
   itinerary(L3, [], Trip).

% itinerary(Criteria, PathSoFar, Itinerary)
%
% in finding connections, the criteria needs to be updated each
% time, not only do we need to find the next hop, but it has to
% leave after the arrival time of the previous hop.
itinerary(Criteria, Path, It) :- stub.
  