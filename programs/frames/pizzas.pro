% pizzas.pro - using frames, ontology, and 
% rules to price and critique pizzas.

%-------------------------------------------
% pizzas/0
%
% The test entry point that goes through the
% existing pizza frames and prices and critiques each.
%

pizzas :-
  frame(pizza, Name, Props),
  price_pizza(Props, Cost, Critique),
  write(Name), nl,
  tab(2), write(Critique), nl,
  tab(2), write(Cost), nl,
  nl,
  fail.
pizzas.

%------------------------------------------
% The pizza frames.
%

pizza(frank, 
  [size=large, toppings=[pepperoni, mushroom],
   crust=thin, style = veggy]).
pizza(sue,
  [size=medium, toppings=[onion, peppers, garlic],
   double_cheese = yes, style = veggy]).
pizza(bob,
  [style=hawaiian, crust=thin, double_cheese = yes, size = medium]).
pizza(sally,
  [toppings = [anchovies], style=hawaiian, crust=thin, double_cheese = yes]).
pizza(sam,
  [crust=thin, toppings = [anchovies, sausage, meatball, onion, garlic, mushroom], size = large]).

%------------------------------------------------
% An ontology about pizza.
%
% Definitions of words used in talking about pizzas.
%

transitive(word, kind_of).

word(anchovies, [
     kind_of = meat_topping,
     clashes_with = hawaiian,
     clashes_with = veggy ]).
word(garlic, [
     kind_of = veggy_topping ]).
word(meatball, [
     kind_of = meat_topping,
     clashes_with = veggy ]).
word(meat_topping, [
     kind_of = topping]).
word(mushroom, [
     kind_of = veggy_topping ]).
word(onion, [
     kind_of = veggy_topping ]).
word(pepperoni, [
     kind_of = meat_topping,
     clashes_with = veggy ]).
word(sausage, [
     kind_of = meat_topping,
     clashes_with = veggy,
     clashes_with = hawaiian ]).
word(veggy_topping, [
     kind_of = topping ]).


%--------------------------------------------------------
% order/0
%
% Let's you order a pizza, then prices and critiques it.
%

prompt(P, A) :-
  write(P),
  read(A).

order :-
  prompt(`What's your name? `, Name),
  create_frame(pizza, Name),
  prompt(`What size [small, medium, large]? `, Size),
  add_property(pizza, Name, size = Size),
  ( prompt(`Hawaiian style? `, yes) ->
      add_property(pizza, Name, style = hawaiian)
      ;
      true ),
  ( prompt(`Veggy style? `, yes) ->
      add_property(pizza, Name, style = veggy)
      ;
      true ),
  (prompt(`Double cheese? `, yes) ->
      add_property(pizza, Name, double_cheese = yes)
      ;
      true ),
  prompt(`What toppings? `, Toppings),
  add_property(pizza, Name, toppings = Toppings),
  go_figure(Name).

go_figure(Name) :-
  pizza(Name, Props),
  price_pizza(Props, Cost, Critique),
  write(`That will be: `),
  write(Cost),
  write(` dollars, and might I add that `), nl,
  write(Critique).

%----------------------------------------------
% price_pizza(Properties, Cost, Critique)
%
% Given the properties for a pizza, figure
% it's cost and express an opinion.
%
% It uses a combination of pattern matching
% and rules. Use match and match_list and other Prolog tools.
%
% Cost Rules:
%   large 12, medium 10, small 8
%   two toppings included
%   extra toppings 1 each
%   a hawaiian implies two toppings to start with
%   double cheese adds 1
%   (optional - maybe extra meat toppings are 2, veggie toppings 1)
%
% Critique Rules:
%   tell them if we don't have a topping they requested
%   use the ontology for toppings to see if the toppings clash
%   more than 4 toppings on a thin crust will cause indigestion
%   anything else is yummy

price_pizza(Properties, Cost, Critique) :- stub.

critique(Props, Critique) :-
   stub,
   stringlist_concat( [`Sorry, we don't have `, Top, ` topping.`], Critique).
critique(Props, Critique) :-
   stub,
   stringlist_concat( [Top, ` on a `, Style, ` pizza??? You have to be kidding.`], Critique).
critique(Props, `That's indigestion city`) :-
   stub.
critique(_, `Yummy`).

