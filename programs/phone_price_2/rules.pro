/*
Pricer 2

Illustrates a custom rule engine for pricing rules like these:

If a call was made on a weekend the price is 5 cents a minute.
If a call was made during the week after 8pm the price is 7 cents a minute.
If a call was made during the week before 8pm the price is 9 cents a minute.
*/

:- include('opdefs.pro').

% The rules
rule(r1, [
  goal :: price = duration * 5,
  conditions :: day_type = weekend
  ]).
  
rule(r2, [
  goal :: price = duration * 7,
  conditions :: day_type = weekday and start >= 2000
  ]).
  
rule(r3, [
  goal :: price = duration * 9,
  conditions :: day_type = weekday and start < 2000
  ]).

rule(r4, [
  goal :: day_type = weekend,
  conditions :: day = saturday or day = sunday
  ]).

rule(r5, [
  goal :: day_type = weekday,
  conditions :: day \= saturday and day \= sunday
  ]).
