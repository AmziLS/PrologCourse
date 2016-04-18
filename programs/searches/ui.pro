/* ui_1.pro - user interface for chapter 1 */

main :-
   write($from? $), read(FROM),
   write($to? $), read(TO),
   path(FROM,TO,PATH),
   write(PATH), nl,
   fail.
main.


