% job_main.pro

% Expert system with frame design
%
% This is the test harness, to run from Prolog.
% The system could be embedded in C++, Java, VB, Delphi, ...
% If so, prompt/3 would be defined in the UI language.
%

:- ensure_loaded(list).
:- import(list).

main :-
   % reconsult(jobs_kb),
   initialize,
   find_job(JOB, DESC),
   write('You could be a '),
   write(JOB), nl,
   write('The job requires: '), write(DESC),
   nl, nl,
   fail.
main.

prompt(P, C, A) :-
   write(P), tab(1), write(C), tab(1),
   read_string(S),
   string_term(S,A).
