% jobs_kb.pro

% This is the knowledge base for the job finder
% application.  The knowledge is represented in
% frame structures.

job('computer scientist',[
   description = `pushing cars back up hills`,
   conditions = [practical = yes, social = no]
   ]).
job('politician',[
   description = `dishonest deception`,
   conditions = [practical = yes, social = yes]
   ]).
job('actor',[
   description = `honest deception`,
   conditions = [social = yes, practical = no, artistic = yes]
   ]).
job('accountant',[
   description = `semi honest deception`,
   conditions = [practical = yes, social = no]
   ]).

question(practical,[
   prompt = `Are you practical? `,
   choices = yes/no
   ]).
question(social,[
   prompt = `Are you social? `,
   choices = yes/no
   ]).
question(artistic,[
   prompt = `Are you artistic? `,
   choices = yes/no
   ]).
