/*
Pricer 1

Illustrates pricing rules for these rules:

If a call was made on a weekend
  the price is 5 cents a minute.
If a call was made during the week after 8pm
  the price is 7 cents a minute.
If a call was made during the week before 8pm
  the price is 10 cents a minute.
*/

% Input Data
% phone_call(ID, DAY, TIME, DURATION)
% phone_call/4
phone_call(1, tuesday, 1800, 10).
phone_call(2, wednesday, 2200, 10).
phone_call(3, saturday, 2200, 10).
phone_call(4, monday, 1600, 10).
phone_call(5, sunday, 800, 10).

% Pricing Rules

price_call(Day, Time, Duration, Price) :-
   rate(Day, Time, Rate),
   Price is Rate * Duration.

rate(Day, _, 5) :-
   weekend(Day).
rate(Day, Time, 7) :-
   weekday(Day),
   evening(Time).
rate(Day, Time, 9) :-
   weekday(Day),
   daytime(Time).

weekend(saturday).
weekend(sunday).

weekday(monday).
weekday(tuesday).
weekday(wednesday).
weekday(thursday).
weekday(friday).

evening(Time) :-
   Time > 2000.

daytime(Time) :-
   Time =< 2000.
   
% Test loop

main :-
   phone_call(ID, Day, Time, Duration),
   price_call(Day, Time, Duration, Price),
   write(ID = Price),
   nl,
   fail.
main.

   