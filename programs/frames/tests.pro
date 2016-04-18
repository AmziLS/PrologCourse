pl(one, [color=blue, height=5, wheels=3, shape=round, season=winter]).
pl(two, [wheels=5, color=green, shape=round]).
pl(three, [trees=yes, leaves=purple, color=blue, wheels=2]).
pl(four, [color=yellow, wheels=3, legs=5]).

pl(five, [ color = [blue, green, yellow], wheels = 7, style = delux ]).
pl(six, [ height = 14, wings = long, color = [green, red, white]] ).

transitive(word, kind_of).
transitive(word, contains).

word(pizza, [ kind_of = food, shape = disc,
              contains = [tomato_sauce, cheese]] ).
word(tomato_sauce, [ kind_of = food, contains = tomatoes ]).
word(frisbee, [ kind_of = sport, equipment = frisbee ]).
word(frisbee, [ kind_of = equipment, shape = disc ]).
word(orange, [kind_of = tree]).
word(tree, [kind_of = plant]).
word(plant, [kind_of = life_form]).
word(cookie, [kind_of = food, contains = [chocolate, peanuts]]).

person(bob, [allergy = tomatoes]).
person(sue, [allergy = peanuts]).

cannot_eat(Person, Food) :-
   find_frame(person, Person, allergy = A),
   find_frame(word, Food, [kind_of = food, contains = A]).

tri_colors(P) :-
   find_frame(pl, P, count(color, 3)).

multi_wheels(P) :-
   find_frame(pl, P, wheels > 4).
