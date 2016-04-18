% jobs.pro

% This is the reasoning engine that makes use of the
% knowledge base.  It starts by finding a job, and the
% conditions for that job.  It then tests those conditions
% against the person's answers to questions.

initialize :-
   retractall(known(_,_)).

find_job(JOB, DESC) :-
   get_slot(job, JOB, conditions, CONDS),
   test_conds(CONDS),
   get_slot(job, JOB, description, DESC).

% go through the attr = value pairs for the job and
% ask the user about each.  If they all match, it's a fit.
% If not, then backtracking will try the next job.
% ask/2 remembers the answers so the questions don't need
% to be asked again.

test_conds([]).
test_conds([ATTR = VAL|REST]) :-
   ask(ATTR,VAL),
   test_conds(REST).

% ask is a predicate that remembers answers to questions so
% they don't need to be asked again.  The remembered answers
% are in known/2.  Note that ask/2 succeeds or fails depending
% on whether the value of the attribute is the one sought.

ask(ATTR,VAL) :-
   known(ATTR,X),
   !,
   X = VAL.
ask(ATTR,VAL) :-
   get_slot(question, ATTR, prompt, PROMPT),
   get_slot(question, ATTR, choices, CHOICES),
   prompt(PROMPT, CHOICES, X),
   assert(known(ATTR,X)),
   X = VAL.
