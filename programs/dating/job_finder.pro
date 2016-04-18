% simple job matcher prototype

% This program illustrates a simple matcher
% algorithm, that, in this case, lines up
% people and their attributes and jobs that
% might suit them.  It uses attribute-value
% lists and recursive list predicates to
% allow a very flexible means for representing
% job criteria.

% Here's a sample run of the program:
% 
% ?- main.
% Are you practical (yes/no) no
% Are you social (yes/no) yes
% You should be a actor
% 
% yes
% ?- main.
% Are you practical (yes/no) yes
% Are you social (yes/no) no
% You should be a computer scientist
%
% Trace the execution of the program to understand
% how it works.


% Program uses member/2 which is defined in the
% list library.  Alternatively, member/2 could
% be defined in this program.

:- ensure_loaded(list).
:- import(list).

% The main predicate - get the client job
% attributes (by asking the user in this case)
% find the job for them and tell them

main :-
   get_client_attributes(CLIENT_ATTRIBUTES),
   find_job(JOB, CLIENT_ATTRIBUTES),
   write(`You should be a `), write(JOB), nl.

% The tedious bit about finding the attributes,
% questions/1 has a list of structures of the
% form ATTRIBUTE - PROMPT.  These will be used
% to ask the user the question and get a value
% for the attribute.

% Note on operators: the '-' in ATTR-PROMPT is
% just a Prolog operator.  It means nothing and
% is just a structure, really '-'(ATTR,PROMPT),
% written in operator format.  Operators used
% like this are often confusing to new Prolog
% users, because they seem more significant than
% they are.  The program could be written with
% attr_prompt_pair(practical, $Are you...$)
% instead.  An '=' will be used later in the
% same way.  The advantage of operators is
% they look cool.

questions([
   practical - `Are you practical (yes/no) `,
   social - `Are you social (yes/no) ` ]).

% pick up the question list, and ask the client
% each, getting a list of client's attibutes
% in return

get_client_attributes(CLIENT_ATTRIBUTES) :-
   questions(QUESTIONS),
   ask_client(QUESTIONS, CLIENT_ATTRIBUTES).

% recursive loop to ask each question and store
% the answer in the output list.  The output
% list will be a list of ATTRIBUTE = VALUE
% pairs.

ask_client([], []).
ask_client([ATTR-PROMPT|QUESTIONS], [ATTR = ANS|CLIENT_ATTRIBUTES]) :-
   write(PROMPT), read_string(STRING_ANS),
   string_term(STRING_ANS, ANS),
   ask_client(QUESTIONS, CLIENT_ATTRIBUTES).

% now the knowledge base if you will.  Here's
% the jobs the system knows about, and for each
% we attach a list of attributes and values using
% the '='/2 operator.

job('computer scientist', [practical = yes, social = no, artistic = maybe, enterprising = yes]).
job('politician', [practical = yes, social = yes]).
job('actor', [social = yes, practical = no]).

% and what all of this is meant to illustrate -
% a simple pattern-matcher, which looks for jobs
% that match the attributes of the client.  Take
% each job, see if it fits the client, succeed
% if it does, or backtrack to the next job if
% it doesn't.

find_job(JOB, CLIENT_ATTRIBUTES) :-
   job(JOB, JOB_ATTRIBUTES),
   match(CLIENT_ATTRIBUTES, JOB_ATTRIBUTES).
find_job(nothing, _).

% using member, to check each of the attribute
% value pairs of the client to see if that
% attr=val pair is in the client.  If they
% all are, we have a match.

match([], _).
match([ATTR = VALUE| AVS], LIST) :-
   member(ATTR=VALUE, LIST),
   match(AVS, LIST).

% the point being its very easy to write a
% pattern-matcher that compares things.
% The attribute value pair lists are a
% very flexible way to represent the knowledge
% and can be easily extended.
% The match/2 predicate can be expanded to
% include more sophisticated matching, so
% that whatever intelligence you wanted to
% add to the system can be added.


