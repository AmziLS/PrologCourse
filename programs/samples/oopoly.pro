/*
Simple object-oriented polymorphism in Prolog.

See Exploring Prolog article for details.
*/

member(X, [X|_]). 
member(X, [_|Z]) :- member(X, Z). 

% class definitions for rectangles and circles. 

oo_class( rectangle(H, W), 
      methods([ ( area(A) :- A is H * W ), 
                ( perimeter(P) :- P is 2 * (H + W) ) ]) ). 

oo_class( circle(R), 
      methods([ ( area(A) :- A is pi * R * R ), 
                ( perimeter(P) :- P is 2 * pi * R ) ]) ). 

/*
find the class for the object and its list of methods, 
find the method which matches the message, and 
call the method.
*/

oo_send(Obj, Message) :- 
   oo_class(Obj, methods(Ms)), 
   member((Message :- Method), Ms), 
   call(Method). 

% sample list of shapes

shapes([rectangle(2, 3), circle(10), rectangle(4, 5), circle(4)]). 

% and a main program that backtracks through the list, finding
% the area of each.

main :- 
   shapes(L), 
   member(S, L), 
   oo_send(S, area(A)), 
   write($Area of $), write(S), write($ = $), write(A), nl, 
   fail. 
main.
