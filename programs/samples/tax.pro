/*
See Exploring Prolog Article.

Consider the following simplified tax form,
1040F (F for fantasy, if it were only so
simple and cheap.) 

line 1 wages                       |       | 
line 2 tax - enter 5% of line 1    |       |
line 3 withheld                    |       | 
line 4 refund (line 3 - line 2)    |       | 
*/

main :- tax.

tax:- 
   line('1040F', 4, refund, X), 
   write('They owe you: '), write(X), nl. 

line('1040F', 1, wages, X) :- wages(X). 
line('1040F', 2, tax, X) :- 
   line('1040F', 1, _, WAGES), 
   X is 0.05 * WAGES. 
line('1040F', 3, withheld, X) :- withheld(X). 
line('1040F', 4, refund, X) :- 
   line('1040F', 2, _, TAX), 
   line('1040F', 3, _, WITHHELD), 
   X is WITHHELD - TAX. 

wages(30000). 

withheld(2000). 

